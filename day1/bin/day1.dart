import 'dart:io';

void main(List<String> arguments) {
  var file = File('input/input');
  try {
    List<String> lines = file.readAsLinesSync();
    List<List<int>> columns = [[], []];
    for (var line in lines) {
      var values = line.split("   ");
      columns[0].add(int.parse(values[0]));
      columns[1].add(int.parse(values[1]));
    }
    List<List<int>> sortedLists =
        List.generate(columns.length, (i) => List<int>.from(columns[i]));

    sortedLists[0].sort();
    sortedLists[1].sort();

    List<int> resultListA = [];

    for (int i = 0; i < sortedLists[0].length; i++) {
      resultListA.add(sortedLists[0][i] > sortedLists[1][i]
          ? sortedLists[0][i] - sortedLists[1][i]
          : sortedLists[1][i] - sortedLists[0][i]);
    }

    print('\n⭐ Part A Result: ${resultListA.reduce(
      (value, element) => value + element,
    )} \n');

    Map<int, int> rightColumnOccurances = {};
    for (var value in columns[1]) {
      rightColumnOccurances[value] = rightColumnOccurances.containsKey(value)
          ? rightColumnOccurances[value]! + 1
          : 1;
    }

    List<int> productList = [];
    for (int value in columns[0]) {
      productList.add(value *
          (rightColumnOccurances.containsKey(value)
              ? rightColumnOccurances[value]!
              : 0));
    }

    print(
        '\n⭐ Part B Result: ${productList.reduce((value, element) => value + element)} \n');
  } catch (e) {
    print('failed to read $e');
  }
}
