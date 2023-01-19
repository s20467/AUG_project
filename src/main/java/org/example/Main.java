package org.example;


import java_cup.Lexer;
import java_cup.runtime.Symbol;
import java_cup.sym;

import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;

public class Main {


    public static void main(String[] args) throws Exception {
        // Tworzenie obiektu skanera z pliku HTML
        FileReader reader = new FileReader("test.html");
        HTMLScanner scanner = new HTMLScanner(reader);

        MyParserClassName parser = new MyParserClassName(scanner);

        parser.parse();


//        Symbol token = scanner.next_token();
//        while (token.sym != sym.EOF) {
//            System.out.println("Token type: " + MySymbolsClassName.terminalNames[token.sym] + ", Token value: *" + token.value + "*");
//            token = scanner.next_token();
//        }
    }
}