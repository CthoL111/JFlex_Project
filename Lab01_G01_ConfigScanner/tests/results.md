# Test results (15 tests: 6 normal, 5 boundary, 4 invalid)

Expected results were written BEFORE running. Fill "Actual" after `./run_tests.sh` (PASS or FAIL).

| ID | Kind | Input file | What it checks | Expected output | Actual |
|----|------|-----------|----------------|-----------------|--------|
| N01 | normal | N01_basic.conf | `retries=3` | IDENTIFIER, ASSIGN, INTEGER | |
| N02 | normal | N02_section_string.conf | comment, section, string, integer | 9 tokens | |
| N03 | normal | N03_decimal_boolean.conf | decimal and booleans | 9 tokens | |
| N04 | normal | N04_identifiers.conf | `_` and digits in names | 6 tokens | |
| N05 | normal | N05_string_with_symbols.conf | `#` and `,` inside string | 3 tokens, no comment | |
| N06 | normal | N06_comment_blank_line.conf | trailing comment, blank line | 6 tokens, line 3 | |
| B01 | boundary | B01_empty.conf | empty input | tokens=0 errors=0 | |
| B02 | boundary | B02_keyword_vs_identifier.conf | `true` vs `trueish` | BOOLEAN, IDENTIFIER, BOOLEAN, IDENTIFIER | |
| B03 | boundary | B03_integer_vs_decimal.conf | `2` vs `2.5` | INTEGER, then 3 DECIMAL | |
| B04 | boundary | B04_adjacent_tokens.conf | tokens with no spaces | 9 tokens | |
| B05 | boundary | B05_crlf_no_final_newline.conf | CRLF, end of input | 6 tokens, line 2 starts at col 1 | |
| E01 | invalid | E01_unterminated_string.conf | missing closing quote | ERROR at 1:8, continues on line 2 | |
| E02 | invalid | E02_unexpected_char.conf | `@` | ERROR at 1:10, continues | |
| E03 | invalid | E03_malformed_number.conf | `1.` and `3.4.5` | ERROR at 1:9, ERROR `.` at 2:8 | |
| E04 | invalid | E04_negative_and_non_ascii.conf | `-` and `ï` outside string | ERROR at 1:9 and 2:3 | |

## Bug record (fill in with a REAL bug your group finds)
- Bug found: (describe what output was wrong)
- Cause: (which rule or option)
- Fix: (what you changed)
- New test: R01 (add input, expected, result here)
