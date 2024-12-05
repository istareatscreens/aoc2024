import 'dart:io';

void main(List<String> arguments) {
  var file = File('input/input');
  var lines = file.readAsLinesSync();
  Map<int, List<int>> numbersAllowedBefore = {};
  List<List<int>> pages = [];
  bool readingPages = false;
  for (var line in lines) {
    if (line.isEmpty) {
      readingPages = true;
      continue;
    }

    if (readingPages) {
      pages.add(line.split(',').map(int.parse).toList());
      continue;
    }
    var numbers = line.split("|").toList().map(int.parse).toList();

    if (!numbersAllowedBefore.containsKey(numbers[1])) {
      numbersAllowedBefore[numbers[1]] = [];
    }
    numbersAllowedBefore[numbers[1]]!.add(numbers[0]);
  }

  List<List<int>> invalidPages = [];
  List<int> validPagesMiddleNumber = [];
  for (var page in pages) {
    if (validatePage(page, numbersAllowedBefore)) {
      validPagesMiddleNumber.add(page[(page.length / 2).floor()]);
    } else {
      invalidPages.add(page);
    }
  }

  List<int> fixedPagesMiddleNumber = [];
  while (invalidPages.isNotEmpty) {
    List<int> indexesToRemove = [];
    for (int m = 0; m < invalidPages.length; m++) {
      var page = invalidPages[m];
      for (var i = 0; i < page.length; i++) {
        var currentNumber = page[i];
        for (int j = i + 1; j < page.length; j++) {
          if (numbersAllowedBefore.containsKey(currentNumber) &&
              numbersAllowedBefore[currentNumber]!.contains(page[j])) {
            page[i] = page[j];
            page[j] = currentNumber;
            break;
          }
        }
      }
      invalidPages[m] = page;
    }
    for (int n = 0; n < invalidPages.length; n++) {
      if (!validatePage(invalidPages[n], numbersAllowedBefore)) {
        continue;
      }
      indexesToRemove.add(n);
      fixedPagesMiddleNumber
          .add(invalidPages[n][(invalidPages[n].length / 2).floor()]);
    }
    for (var index in indexesToRemove.reversed) {
      invalidPages.removeAt(index);
    }
  }

  print(
      '\n⭐ Part A Result: ${validPagesMiddleNumber.fold(0, (value, element) => value + element)} \n');
  print(
      '\n⭐ Part B Result: ${fixedPagesMiddleNumber.fold(0, (value, element) => value + element)} \n');
}

bool validatePage(List<int> page, Map<int, List<int>> numbersAllowedBefore) {
  var validPage = true;
  loop:
  for (var i = 0; i < page.length; i++) {
    for (int j = i + 1; j < page.length; j++) {
      if (numbersAllowedBefore.containsKey(page[i]) &&
          numbersAllowedBefore[page[i]]!.contains(page[j])) {
        validPage = false;
        break loop;
      }
    }
  }
  return validPage;
}
