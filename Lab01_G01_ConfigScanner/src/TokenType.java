public enum TokenType {
    IDENTIFIER, BOOLEAN, INTEGER, DECIMAL, STRING, ASSIGN, LBRACKET, RBRACKET,
    ERROR_UNEXPECTED_CHAR, ERROR_UNTERMINATED_STRING, ERROR_MALFORMED_NUMBER;

    public boolean isError() {
        return name().startsWith("ERROR_");
    }
}
