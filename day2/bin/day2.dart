import 'dart:io';

void main(List<String> arguments) {
  var file = File('input/input');
  try {
    List<String> lines = file.readAsLinesSync();
    List<List<int>> reports = [];
    var resultPart1 = 0;
    var resultPart2 = 0;
    for (var line in lines) {
      var report = line.split(" ").map(int.parse).toList();
      if (!checkSafety(report)) {
        reports.add(report);
        continue;
      }
      resultPart1++;
      resultPart2++;
    }

    for (var report in reports) {
      for (int i = 0; i < report.length; i++) {
        if (!checkSafety([...report.sublist(0, i), ...report.sublist(i + 1)])) {
          continue;
        }
        resultPart2++;
        break;
      }
    }

    print('\n⭐ Part A Result: $resultPart1 \n');
    print('\n⭐ Part B Result: $resultPart2 \n');
  } catch (e) {
    print("Error: $e");
  }
}

bool checkSafety(List<int> report) {
  var prevNumber = -1;
  bool isIncreasing = report[0] < report[1];
  var safe = true;
  for (var number in report) {
    if (-1 == prevNumber) {
      prevNumber = number;
      continue;
    }
    var diff = (number - prevNumber).abs();
    safe = safe &&
        0 < diff &&
        4 > diff &&
        ((isIncreasing && prevNumber < number) ||
            (!isIncreasing && prevNumber > number));
    if (!safe) {
      break;
    }
    prevNumber = number;
  }
  return safe;
}
