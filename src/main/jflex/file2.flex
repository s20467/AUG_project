/* JFlex example: partial Java language lexer specification */
import java_cup.runtime.*;
import java_cup.sym;

/**
 * This class is a simple example lexer.
 */
%%

%class HTMLScanner
%unicode
%cup
%line
%column

%{
  StringBuffer string = new StringBuffer();

  ComplexSymbolFactory symbolFactory = new ComplexSymbolFactory();

  private Symbol symbol(int type) {
    return new Symbol(type, yyline, yycolumn);
  }
  private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline, yycolumn, value);
  }
%}

LineTerminator=\r|\n|\r\n
InputCharacter=[^\r\n]
WhiteSpace={LineTerminator} | [ \t\f]

Equality==

Doctype=<\!DOCTYPE{WhiteSpace}html>

AlphaSequence=[a-zA-Z]+
AlphanumericSequence=[a-zA-Z0-9]+
AlphanumericSequenceWithSpaces=({AlphanumericSequence}|{WhiteSpace})+
CharSequence=[^\r\n<]+

TagOpeningStart=<{AlphanumericSequence}+
TagOpeningEnd=>

TagClosing=<\/{AlphanumericSequence}+>

//SingleTagStart=<{AlphanumericSequence}+
SingleTagEnd=\/?>

Comment=<!--(.*?)-->

//ok=<\!DOCTYPE.+




%state TAG_INSIDE
%state ATTRIBUTE_VALUE

%%

/* keywords */
<YYINITIAL> {
  {Comment}                 { /* ignore */ }
  {WhiteSpace}+             { /* ignore */ }
  {Doctype}                 { return symbol(MySymbolsClassName.DOCTYPE, yytext()); }
  {TagOpeningStart}         {
                                yybegin(TAG_INSIDE);
                                return symbol(MySymbolsClassName.TAG_OPENING_START, yytext());
                            }
  {TagClosing}              { return symbol(MySymbolsClassName.TAG_CLOSING, yytext()); }
//  {SingleTagStart}          {
//                                yybegin(TAG_INSIDE);
//                                return symbol(MySymbolsClassName.SINGLE_TAG_START, yytext());
//                            }
  {Equality}                { return symbol(MySymbolsClassName.EQUALITY, yytext()); }
  {CharSequence}            { return symbol(MySymbolsClassName.CHAR_SEQUENCE, yytext()); }
}

<TAG_INSIDE> {
  {Comment}                 { /* ignore */ }
  {TagOpeningEnd}           {
                                yybegin(YYINITIAL);
                                return symbol(MySymbolsClassName.TAG_OPENING_END, yytext());
                            }
  {SingleTagEnd}            {
                                yybegin(YYINITIAL);
                                return symbol(MySymbolsClassName.SINGLE_TAG_END, yytext());
                            }
  {AlphaSequence}           { return symbol(MySymbolsClassName.TAG_ATTRIBUTE_NAME, yytext()); }
  {Equality}                {
                                yybegin(ATTRIBUTE_VALUE);
                                return symbol(MySymbolsClassName.EQUALITY, yytext());
                            }
  {WhiteSpace}+             { /* ignore */ }
}

<ATTRIBUTE_VALUE> {
//  \"([^\"])\" | \'([^\'])\' | [^\s>\/]+
  {WhiteSpace}*(([^\r\n\">]+)|(\"[^\r\n\"]+\"))             {
                                                    yybegin(TAG_INSIDE);
                                                    return symbol(MySymbolsClassName.TAG_ATTRIBUTE_VALUE, yytext());
                                                }
}


