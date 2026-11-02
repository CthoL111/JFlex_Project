@echo off
rem Usage: build.bat   (needs lib\jflex-full-1.9.1.jar, or edit JFLEX below)
set JFLEX=lib\jflex-full-1.9.1.jar
if not exist generated mkdir generated
if not exist out mkdir out
java -jar %JFLEX% -d generated src\config.jflex || exit /b 1
javac -encoding UTF-8 -d out generated\ConfigScanner.java src\Token.java src\TokenType.java src\Main.java || exit /b 1
echo Build OK
