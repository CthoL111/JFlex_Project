#!/bin/sh
# Runs every tests/inputs/*.conf and compares with tests/expected/*.out
mkdir -p tests/actual
pass=0; fail=0
for f in tests/inputs/*.conf; do
  id=$(basename "$f" .conf)
  java -cp out Main "$f" > "tests/actual/$id.out"
  if diff -q "tests/expected/$id.out" "tests/actual/$id.out" > /dev/null; then
    echo "PASS $id"; pass=$((pass+1))
  else
    echo "FAIL $id"; fail=$((fail+1))
  fi
done
echo "passed=$pass failed=$fail"
