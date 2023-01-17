package org.example;

public class sym2 {
    public static final int TAG_OPENING_START = 0;
    public static final int TAG_OPENING_END = 1;
    public static final int TAG_CLOSING = 2;
    public static final int SINGLE_TAG_START = 3;
    public static final int SINGLE_TAG_END = 4;
    public static final int TAG_ATTRIBUTE_NAME = 5;
    public static final int TAG_ATTRIBUTE_VALUE = 6;
    public static final int CHAR_SEQUENCE = 7;
    public static final int ALPHANUMERIC_SEQUENCE_SPACES = 8;
    public static final int EQUALITY = 9;
    public static final int EOF = 10;
    public static final int DOCTYPE = 11;
    public static final int TEST = 12;

    public static String getName(int field) {
        return switch (field) {
            case TAG_OPENING_START -> "TAG_OPENING_START";
            case TAG_OPENING_END -> "TAG_OPENING_END";
            case TAG_CLOSING -> "TAG_CLOSING";
            case SINGLE_TAG_START -> "SINGLE_TAG_START";
            case SINGLE_TAG_END -> "SINGLE_TAG_END";
            case TAG_ATTRIBUTE_NAME -> "TAG_ATTRIBUTE_NAME";
            case TAG_ATTRIBUTE_VALUE -> "TAG_ATTRIBUTE_VALUE";
            case CHAR_SEQUENCE -> "CHAR_SEQUENCE";
            case ALPHANUMERIC_SEQUENCE_SPACES -> "ALPHANUMERIC_SEQUENCE_SPACES";
            case EQUALITY -> "EQUALITY";
            case EOF -> "EOF";
            case DOCTYPE -> "DOCTYPE";
            case TEST -> "TEST";
            default -> "UNKNOWN";
        };
    }
}












