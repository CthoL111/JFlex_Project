/* config.jflex
 * Lab01 JFlex Group Project - Configuration File Scanner
 * Input : UTF-8 text file in a small "key = value" format
 * Output: one line per token (see Main.java)
 */
%%

%public
%class ConfigScanner
%unicode
%line
%column
%type Token
%function nextToken

%{
  /* JFlex counters start at 0, so we add 1 to show human positions. */
  private Token token(TokenType type) {
    return new Token(type, yytext(), yyline + 1, yycolumn + 1);
  }
%}

/* ---------- named macros ---------- */
LETTER      = [a-zA-Z_]
DIGIT       = [0-9]
IDENT       = {LETTER} ({LETTER} | {DIGIT})*
INTEGER     = {DIGIT}+
REAL_PORT   = {DIGIT}+ ("." {DIGIT}+){3}
DECIMAL     = {DIGIT}+ "." {DIGIT}+
BAD_NUMBER  = {DIGIT}+ "."
STRING      = "\"" [^\"\r\n]* "\""
OPEN_STRING = "\"" [^\"\r\n]*
COMMENT     = "#" [^\r\n]*
WHITESPACE  = [ \t\r\n]+

%%

/* ---------- rules ----------
 * JFlex picks the LONGEST match; on equal length it picks the FIRST rule.
 * So BOOLEAN must be written before IDENT.
 */
"true" | "false"  { return token(TokenType.BOOLEAN); }
{REAL_PORT}   { return token(TokenType.REAL_PORT); }
{IDENT}           { return token(TokenType.IDENTIFIER); }
{DECIMAL}         { return token(TokenType.DECIMAL); }
{BAD_NUMBER}      { return token(TokenType.ERROR_MALFORMED_NUMBER); }
{INTEGER}         { return token(TokenType.INTEGER); }
{STRING}          { return token(TokenType.STRING); }
{OPEN_STRING}     { return token(TokenType.ERROR_UNTERMINATED_STRING); }
"="               { return token(TokenType.ASSIGN); }
"["               { return token(TokenType.LBRACKET); }
"]"               { return token(TokenType.RBRACKET); }

{COMMENT}         { /* skip comment */ }
{WHITESPACE}      { /* skip whitespace */ }

/* anything else is a lexical error; scanning CONTINUES after it */
[^]               { return token(TokenType.ERROR_UNEXPECTED_CHAR); }

<<EOF>>           { return null; }
