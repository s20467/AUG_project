/* JFlex example: partial Java language lexer specification */
import java_cup.runtime.*;
import java_cup.sym;
import org.example.MySymbolsClassName;
import java.util.Map;
import static java.util.Map.entry;

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

  Map<String, Integer> openingTagStartSymbolMap = Map.ofEntries(
    entry("a", MySymbolsClassName.TAG_A_OPENING_START),
    entry("article", MySymbolsClassName.TAG_ARTICLE_OPENING_START),
    entry("b", MySymbolsClassName.TAG_B_OPENING_START),
    entry("body", MySymbolsClassName.TAG_BODY_OPENING_START),
    entry("button", MySymbolsClassName.TAG_BUTTON_OPENING_START),
    entry("div", MySymbolsClassName.TAG_DIV_OPENING_START),
    entry("footer", MySymbolsClassName.TAG_FOOTER_OPENING_START),
    entry("form", MySymbolsClassName.TAG_FORM_OPENING_START),
    entry("h1", MySymbolsClassName.TAG_H1_OPENING_START),
    entry("h2", MySymbolsClassName.TAG_H2_OPENING_START),
    entry("h3", MySymbolsClassName.TAG_H3_OPENING_START),
    entry("h4", MySymbolsClassName.TAG_H4_OPENING_START),
    entry("h5", MySymbolsClassName.TAG_H5_OPENING_START),
    entry("h6", MySymbolsClassName.TAG_H6_OPENING_START),
    entry("head", MySymbolsClassName.TAG_HEAD_OPENING_START),
    entry("header", MySymbolsClassName.TAG_HEADER_OPENING_START),
    entry("html", MySymbolsClassName.TAG_HTML_OPENING_START),
    entry("i", MySymbolsClassName.TAG_I_OPENING_START),
    entry("label", MySymbolsClassName.TAG_LABEL_OPENING_START),
    entry("li", MySymbolsClassName.TAG_LI_OPENING_START),
    entry("nav", MySymbolsClassName.TAG_NAV_OPENING_START),
    entry("ol", MySymbolsClassName.TAG_OL_OPENING_START),
    entry("option", MySymbolsClassName.TAG_OPTION_OPENING_START),
    entry("p", MySymbolsClassName.TAG_P_OPENING_START),
    entry("select", MySymbolsClassName.TAG_SELECT_OPENING_START),
    entry("span", MySymbolsClassName.TAG_SPAN_OPENING_START),
    entry("style", MySymbolsClassName.TAG_STYLE_OPENING_START),
    entry("table", MySymbolsClassName.TAG_TABLE_OPENING_START),
    entry("tbody", MySymbolsClassName.TAG_TBODY_OPENING_START),
    entry("td", MySymbolsClassName.TAG_TD_OPENING_START),
    entry("textarea", MySymbolsClassName.TAG_TEXTAREA_OPENING_START),
    entry("tfoot", MySymbolsClassName.TAG_TFOOT_OPENING_START),
    entry("th", MySymbolsClassName.TAG_TH_OPENING_START),
    entry("thead", MySymbolsClassName.TAG_THEAD_OPENING_START),
    entry("title", MySymbolsClassName.TAG_TITLE_OPENING_START),
    entry("tr", MySymbolsClassName.TAG_TR_OPENING_START),
    entry("u", MySymbolsClassName.TAG_U_OPENING_START),
    entry("ul", MySymbolsClassName.TAG_UL_OPENING_START)
  );

  Map<String, Integer> singleTagStartSymbolMap = Map.ofEntries(
      entry("br", MySymbolsClassName.TAG_BR_OPENING),
      entry("img", MySymbolsClassName.TAG_IMG_OPENING),
      entry("input", MySymbolsClassName.TAG_INPUT_OPENING),
      entry("link", MySymbolsClassName.TAG_LINK_OPENING),
      entry("meta", MySymbolsClassName.TAG_META_OPENING)
    );

  Map<String, Integer> closingTagSymbolMap = Map.ofEntries(
      entry("a", MySymbolsClassName.TAG_A_CLOSING),
      entry("article", MySymbolsClassName.TAG_ARTICLE_CLOSING),
      entry("b", MySymbolsClassName.TAG_B_CLOSING),
      entry("body", MySymbolsClassName.TAG_BODY_CLOSING),
      entry("button", MySymbolsClassName.TAG_BUTTON_CLOSING),
      entry("div", MySymbolsClassName.TAG_DIV_CLOSING),
      entry("footer", MySymbolsClassName.TAG_FOOTER_CLOSING),
      entry("form", MySymbolsClassName.TAG_FORM_CLOSING),
      entry("h1", MySymbolsClassName.TAG_H1_CLOSING),
      entry("h2", MySymbolsClassName.TAG_H2_CLOSING),
      entry("h3", MySymbolsClassName.TAG_H3_CLOSING),
      entry("h4", MySymbolsClassName.TAG_H4_CLOSING),
      entry("h5", MySymbolsClassName.TAG_H5_CLOSING),
      entry("h6", MySymbolsClassName.TAG_H6_CLOSING),
      entry("head", MySymbolsClassName.TAG_HEAD_CLOSING),
      entry("header", MySymbolsClassName.TAG_HEADER_CLOSING),
      entry("html", MySymbolsClassName.TAG_HTML_CLOSING),
      entry("i", MySymbolsClassName.TAG_I_CLOSING),
      entry("label", MySymbolsClassName.TAG_LABEL_CLOSING),
      entry("li", MySymbolsClassName.TAG_LI_CLOSING),
      entry("nav", MySymbolsClassName.TAG_NAV_CLOSING),
      entry("ol", MySymbolsClassName.TAG_OL_CLOSING),
      entry("option", MySymbolsClassName.TAG_OPTION_CLOSING),
      entry("p", MySymbolsClassName.TAG_P_CLOSING),
      entry("select", MySymbolsClassName.TAG_SELECT_CLOSING),
      entry("span", MySymbolsClassName.TAG_SPAN_CLOSING),
      entry("style", MySymbolsClassName.TAG_STYLE_CLOSING),
      entry("table", MySymbolsClassName.TAG_TABLE_CLOSING),
      entry("tbody", MySymbolsClassName.TAG_TBODY_CLOSING),
      entry("td", MySymbolsClassName.TAG_TD_CLOSING),
      entry("textarea", MySymbolsClassName.TAG_TEXTAREA_CLOSING),
      entry("tfoot", MySymbolsClassName.TAG_TFOOT_CLOSING),
      entry("th", MySymbolsClassName.TAG_TH_CLOSING),
      entry("thead", MySymbolsClassName.TAG_THEAD_CLOSING),
      entry("title", MySymbolsClassName.TAG_TITLE_CLOSING),
      entry("tr", MySymbolsClassName.TAG_TR_CLOSING),
      entry("u", MySymbolsClassName.TAG_U_CLOSING),
      entry("ul", MySymbolsClassName.TAG_UL_CLOSING)
    );

  StringBuffer string = new StringBuffer();

  ComplexSymbolFactory symbolFactory = new ComplexSymbolFactory();

  private Symbol symbol(int type) {
    return new Symbol(type, yyline, yycolumn);
  }
  private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline, yycolumn, value);
  }

  private Integer getOpeningTagSymbol(String value) {
      value = value.trim().substring(1).trim();
      return openingTagStartSymbolMap.get(value);
  }

  private Integer getClosingTagSymbol(String value) {
      value = value.trim().substring(2).trim();
      value = value.substring(0, value.length()-1).trim();
      return closingTagSymbolMap.get(value);
  }

  private Integer getSingleOpeningTagSymbol(String value) {
      value = value.trim().substring(1).trim();
      if(value.charAt(0) == '/') {
          value = value.substring(1).trim();
      }
      if(value.charAt(value.length()-1) == '/') {
          value = value.substring(0, value.length()-1);
      }
      return singleTagStartSymbolMap.get(value);
  }
%}

SingleTagName= (br)|(img)|(input)|(link)|(meta)
DoubleTagName= (a)|(article)|(b)|(body)|(button)|(div)|(footer)|(form)|(h1)|(h2)|(h3)|(h4)|(h5)|(h6)|(head)|(header)|(html)|(i)|(label)|(li)|(nav)|(ol)|(option)|(p)|(select)|(span)|(style)|(table)|(tbody)|(td)|(textarea)|(tfoot)|(th)|(thead)|(title)|(tr)|(u)|(ul)


LineTerminator=\r|\n|\r\n
InputCharacter=[^\r\n]
WhiteSpace={LineTerminator} | [ \t\f]

Equality==

Doctype=<\!DOCTYPE{WhiteSpace}html>

AlphaSequence=[a-zA-Z]+
AlphanumericSequence=[a-zA-Z0-9]+
AlphanumericSequenceWithSpaces=({AlphanumericSequence}|{WhiteSpace})+
CharSequence=[^\r\n<]+

TagOpeningStart=<{DoubleTagName}

SingleTagStart=<{SingleTagName}


TagOpeningEnd=>

TagClosing=<\/{AlphanumericSequence}+>

//SingleTagStart=<{AlphanumericSequence}+
SingleTagEnd=\/>

Comment=<\!--(.*)-->

CommentStart=<\!--
CommentEnd=-->



//ok=<\!DOCTYPE.+




%state TAG_INSIDE
%state ATTRIBUTE_VALUE
%state COMMENT

%%

/* keywords */
<YYINITIAL> {
  {CommentStart}            { yybegin(COMMENT); }
  {WhiteSpace}+             { /* ignore */ }
  {Doctype}                 { return symbol(MySymbolsClassName.DOCTYPE, yytext()); }
  {TagOpeningStart}         {
                                yybegin(TAG_INSIDE);
                                return symbol(getOpeningTagSymbol(yytext()));
                            }
  {SingleTagStart}          {
                                  yybegin(TAG_INSIDE);
                                  return symbol(getSingleOpeningTagSymbol(yytext()));
                            }
  {TagClosing}              { return symbol(getClosingTagSymbol(yytext())); }
//  {SingleTagStart}          {
//                                yybegin(TAG_INSIDE);
//                                return symbol(MySymbolsClassName.SINGLE_TAG_START, yytext());
//                            }
  {Equality}                { return symbol(MySymbolsClassName.EQUALITY, yytext()); }
  {CharSequence}            { return symbol(MySymbolsClassName.CHAR_SEQUENCE, yytext()); }
}

<TAG_INSIDE> {
  {CommentStart}            { yybegin(COMMENT); }
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

<COMMENT> {
  {CommentEnd}              { yybegin(YYINITIAL); }
  .                         { /* ignore */ }
}


