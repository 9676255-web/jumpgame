```
# jumpgame

This repository contains a simple Java UML diagram generator example.

Structure
- src/
  - Main.java
  - ClassParser.java
  - UMLDiagramGenerator.java
  - UMLClass.java
  - UMLRelation.java
  - utils/FileScanner.java
- example/demoClasses/ (example Java sources)

How to run
1. Build with javac: `javac src/*.java src/utils/*.java`
2. Run: `java -cp src Main [path-to-java-source-root]`
   - If no path is provided it will default to `example/demoClasses`.
3. The program will display a simple Swing window and save a PNG `uml_output.png` in the working directory.

Notes
- This is a small, source-based parser intended for simple demonstration classes. It uses naive parsing and won't handle every Java syntax edge case.
```
