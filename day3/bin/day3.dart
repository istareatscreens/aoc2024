import 'dart:io';

void main(List<String> arguments) {
  var file = File('input/input');
  try {
    var memory = file.readAsStringSync();
    var mulRegExp = RegExp(r"mul\(\d+,\d+\)", multiLine: true);
    var numberRegExp = RegExp(r"\d+", multiLine: true);
    List<int> partAProducts =
        mulRegExp.allMatches(memory).toList().map((match) {
      var numbers = numberRegExp
          .allMatches(match.group(0) ?? "")
          .toList()
          .map((number) => int.parse(number.group(0) ?? ""))
          .toList();
      return numbers[0] * numbers[1];
    }).toList();

    print('\n⭐ Part A Result: ${partAProducts.reduce(
      (value, element) => value + element,
    )} \n');

    var mulDoDontRegExp =
        RegExp(r"(mul\(\d+,\d+\)|do\(\)|don't\(\))", multiLine: true);
    bool read = true;
    List<int> partBProducts =
        mulDoDontRegExp.allMatches(memory).toList().map((match) {
      var matchText = match.group(0).toString();
      if (matchText.startsWith('do()')) {
        read = true;
        return 0;
      } else if (matchText.startsWith('don') || !read) {
        read = false;
        return 0;
      }

      var numbers = numberRegExp
          .allMatches(matchText)
          .toList()
          .map((number) => int.parse(number.group(0) ?? ""))
          .toList();
      return numbers[0] * numbers[1];
    }).toList();
    print(
        '\n⭐ Part B Result: ${partBProducts.reduce((value, element) => value + element)} \n');
  } catch (e) {
    print('failed to read $e');
  }
}
