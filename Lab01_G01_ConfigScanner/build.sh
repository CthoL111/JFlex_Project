#!/bin/sh
# Usage: ./build.sh   (needs lib/jflex-full-1.9.1.jar, or edit JFLEX below)
JFLEX=lib/jflex-full-1.9.1.jar
set -e
mkdir -p generated out
java -jar "$JFLEX" -d generated src/config.jflex          # 1. generate ConfigScanner.java
javac -encoding UTF-8 -d out generated/ConfigScanner.java src/*.java   # 2. compile
echo "Build OK"
