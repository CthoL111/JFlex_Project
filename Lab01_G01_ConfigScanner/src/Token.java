public final class Token {
    public final TokenType type;
    public final String lexeme;
    public final int line;    // 1-based
    public final int column;  // 1-based

    public Token(TokenType type, String lexeme, int line, int column) {
        this.type = type;
        this.lexeme = lexeme;
        this.line = line;
        this.column = column;
    }

    /** Output format: line:column TYPE lexeme */
    @Override
    public String toString() {
        return line + ":" + column + " " + type + " " + lexeme;
    }
}
