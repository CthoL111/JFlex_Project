# Lab01 Report - Configuration File Scanner
Group: 10  
    
Members: 
| Name | Student ID |
|------|-----------|
| YAN CHANTHOL | e20231348 | 
| LY Sengkim | e20231094 | 


## 1. Scope
The scanner reads a small `key = value` configuration format and lists tokens with type, lexeme, line and column (from 1).
It checks only lexical rules. **Left out of scope:** arrays, nested sections and negative numbers. It does not check
statement structure, so `= = 5` is lexically valid.

## 2. Token definitions
| Token | Pattern | Example |
|---|---|---|
| IDENTIFIER | `[a-zA-Z_][a-zA-Z_0-9]*` | `max_users` |
| BOOLEAN | `true` or `false` | `true` |
| INTEGER | `[0-9]+` | `8080` |
| DECIMAL | `[0-9]+ "." [0-9]+` | `2.5` |
| STRING | `"` `[^"\r\n]*` `"` | `"localhost"` |
| ASSIGN | `=` | `=` |
| LBRACKET / RBRACKET | `[` / `]` | `[server]` |
| (skipped) whitespace, comment `#...` | `[ \t\r\n]+`, `"#"[^\r\n]*` | |
| (errors) | unexpected char, unterminated string, malformed number `1.` | `@`, `"abc`, `1.` |

Errors are reported with position and scanning continues. End of input returns null and the driver prints a summary.

## 3. Two competing-rule cases
1. **Keyword vs longer identifier.** For `true`, BOOLEAN and IDENTIFIER both match 4 characters; the tie goes to the
   earlier rule (BOOLEAN). For `trueish`, IDENTIFIER matches 7 characters and BOOLEAN only 4, so the longest match wins
   (IDENTIFIER). Tests B02.
2. **Integer vs decimal.** For `2.5`, INTEGER matches `2` (1 char), DECIMAL matches `2.5` (3 chars), so DECIMAL wins.
   Also `1.`: BAD_NUMBER (2 chars) beats INTEGER (1 char), giving a malformed-number error. Tests B03, E03.

## 4. Automaton for DECIMAL (DFA)
```
            digit                                          digit
      ┌───────────────┐                                     ┌──┐
      ▼               │                                     ▼  │
 ──► (q0) ──digit──► (q1) ──────"."──────► (q2) ──digit──► ((q3))
      │                                     │               │
      │ "."                            "."  │               │ "."
      │                                     │               │
      │                                     ▼               │
      └──────────────────────────────────► (qd) ◄───────────┘
```
Precisely: q0 -digit-> q1; q1 -digit-> q1; q1 -"."-> q2; q2 -digit-> q3; q3 -digit-> q3. Accepting state: q3.
It matches the regex `[0-9]+ "." [0-9]+`: the loop on q1 is `[0-9]+`, the `.` edge is the dot, and q2->q3 with the loop on q3 is the second `[0-9]+`.
If the input stops in q2 (`1.`), the DECIMAL rule fails, which is why we added the BAD_NUMBER rule.

## 5. Bug and correction
(Write a REAL bug your group found: wrong output, cause, fix, and the new test R01. Do not invent one.)

## 6. Test summary
15 tests: 6 normal, 5 boundary, 4 invalid. See `tests/results.md`. Actual results: (fill in after running).

## 7. Contribution record
| Member | Contribution |
|---|---|
| YAN CHANTHOL | e20231348 |
| LY Sengkim | e20231094 |

## 8. Limitations
Listed in README (no negatives, no escapes, ASCII identifiers only, UTF-8 without BOM).
