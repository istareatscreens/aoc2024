import 'dart:io';

const XMAS = "XMAS";

void main(List<String> arguments) {
  var file = File('input/input');
  try {
    List<String> lines = file.readAsLinesSync();
    var resultA = 0;
    for (int i = 0; i < lines.length; i++) {
      for (int j = 0; j < lines[i]!.length; j++) {
        List<bool> matches = [];
        try {
          matches.add((XMAS ==
              (lines[i][j + 0]) +
                  (lines[i][j + 1]) +
                  (lines[i][j + 2]) +
                  (lines[i][j + 3])));
        } catch (e) {}

        try {
          matches.add((XMAS ==
              (lines[i][j + 3]) +
                  (lines[i][j + 2]) +
                  (lines[i][j + 1]) +
                  (lines[i][j + 0])));
        } catch (e) {}
        try {
          matches.add((XMAS ==
              (lines[i + 0][j]) +
                  (lines[i + 1][j]) +
                  (lines[i + 2][j]) +
                  (lines[i + 3][j])));
        } catch (e) {}
        try {
          matches.add((XMAS ==
              (lines[i + 3][j]) +
                  (lines[i + 2][j]) +
                  (lines[i + 1][j]) +
                  (lines[i + 0][j])));
        } catch (e) {}
        try {
          matches.add((XMAS ==
              (lines[i + 3][j + 0]) +
                  (lines[i + 2][j + 1]) +
                  (lines[i + 1][j + 2]) +
                  (lines[i + 0][j + 3])));
        } catch (e) {}
        try {
          matches.add((XMAS ==
              (lines[i + 0][j + 3]) +
                  (lines[i + 1][j + 2]) +
                  (lines[i + 2][j + 1]) +
                  (lines[i + 3][j + 0])));
        } catch (e) {}
        try {
          matches.add((XMAS ==
              (lines[i + 3][j + 3]) +
                  (lines[i + 2][j + 2]) +
                  (lines[i + 1][j + 1]) +
                  (lines[i + 0][j + 0])));
        } catch (e) {}
        try {
          matches.add((XMAS ==
              (lines[i + 0][j + 0]) +
                  (lines[i + 1][j + 1]) +
                  (lines[i + 2][j + 2]) +
                  (lines[i + 3][j + 3])));
        } catch (e) {}
        for (var match in matches) {
          resultA += match ? 1 : 0;
        }
      }
    }
    print('\n⭐ Part A Result: $resultA \n');
    int resultB = 0;
    for (int i = 0; i < lines.length; i++) {
      for (int j = 0; j < lines[i]!.length; j++) {
        try {
          resultB += "M" == lines[i + 0][j + 0] &&
                  "S" == lines[i + 0][j + 2] &&
                  "A" == lines[i + 1][j + 1] &&
                  "M" == lines[i + 2][j] &&
                  "S" == lines[i + 2][j + 2]
              ? 1
              : 0;
        } catch (e) {}
        try {
          resultB += "S" == lines[i + 0][j + 0] &&
                  "M" == lines[i + 0][j + 2] &&
                  "A" == lines[i + 1][j + 1] &&
                  "S" == lines[i + 2][j] &&
                  "M" == lines[i + 2][j + 2]
              ? 1
              : 0;
        } catch (e) {}
        try {
          resultB += "M" == lines[i + 0][j + 0] &&
                  "M" == lines[i + 0][j + 2] &&
                  "A" == lines[i + 1][j + 1] &&
                  "S" == lines[i + 2][j] &&
                  "S" == lines[i + 2][j + 2]
              ? 1
              : 0;
        } catch (e) {}
        try {
          resultB += "S" == lines[i + 0][j + 0] &&
                  "S" == lines[i + 0][j + 2] &&
                  "A" == lines[i + 1][j + 1] &&
                  "M" == lines[i + 2][j] &&
                  "M" == lines[i + 2][j + 2]
              ? 1
              : 0;
        } catch (e) {}
      }
    }

    print('\n⭐ Part B Result: $resultB \n');
  } catch (e) {
    print('failed to read $e');
  }
}
