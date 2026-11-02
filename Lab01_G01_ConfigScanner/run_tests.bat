@echo off
if not exist tests\actual mkdir tests\actual
set PASS=0
set FAIL=0
for %%f in (tests\inputs\*.conf) do (
  java -cp out Main "%%f" > "tests\actual\%%~nf.out"
  fc "tests\expected\%%~nf.out" "tests\actual\%%~nf.out" > nul
  if errorlevel 1 (echo FAIL %%~nf & set /a FAIL+=1) else (echo PASS %%~nf & set /a PASS+=1)
)
echo passed=%PASS% failed=%FAIL%
