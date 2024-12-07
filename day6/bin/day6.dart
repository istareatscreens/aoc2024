import 'dart:io';
import 'package:uuid/uuid.dart';

const obstruction = "#";

cloneList<T>(List<List<T>> list) =>
    List.from(list).map((innerList) => List<T>.from(innerList)).toList();
void main(List<String> arguments) {
  var file = File('input/input');
  var lines = file.readAsLinesSync();
  Map<String, int> visitedPositions = {};
  var currentPosition = [-1, -1, -1];
  var startPosition = [-1, -1, -1];
  List<List<String>> map = [];
  /*
    ^ = 0
    > = 1
    v = 2
    < = 3
  */
  for (int i = 0; i < lines.length; i++) {
    var row = lines[i].split('').toList();
    map.add(row);
    for (int j = 0; j < row.length; j++) {
      if (0 == currentPosition[2]) {
        break;
      }
      if ("^" == row[j]) {
        startPosition = [i, j, 0];
      }
    }
  }
  currentPosition = List.from(startPosition);
  Map<String, bool> pathsTaken = {};

  Map<String, int> loops = {};
  var fullPath = traverseMap(
      map, List.from(currentPosition), visitedPositions, loops, pathsTaken);
  print('\n⭐ Part A Result: ${visitedPositions.keys.toList().length} \n');

  List<List<String>> initialMap = cloneList(map);
  Map<String, bool> placedObstruction = {};
  while (fullPath.isNotEmpty) {
    map = cloneList<String>(initialMap);
    try {
      switch (currentPosition[2]) {
        case 0:
          map[currentPosition[0]][currentPosition[1]] = '>';
          if ("^" == map[currentPosition[0] - 1][currentPosition[1]]) {
            break;
          }
          if (placedObstruction.containsKey(createIndexSyntax(
              [currentPosition[0] - 1, currentPosition[1]]))) {
            currentPosition = fullPath.removeAt(0);
            if (currentPosition == startPosition) {
              currentPosition = fullPath.removeAt(0);
            }
            continue;
          }
          placedObstruction[createIndexSyntax(
              [currentPosition[0] - 1, currentPosition[1]])] = true;
          map[currentPosition[0] - 1][currentPosition[1]] = obstruction;
          currentPosition[2] = 1;
          break;
        case 1:
          map[currentPosition[0]][currentPosition[1]] = 'v';
          if ("^" == map[currentPosition[0]][currentPosition[1] + 1]) {
            break;
          }
          if (placedObstruction.containsKey(createIndexSyntax(
              [currentPosition[0], currentPosition[1] + 1]))) {
            currentPosition = fullPath.removeAt(0);
            if (currentPosition == startPosition) {
              currentPosition = fullPath.removeAt(0);
            }
            continue;
          }
          placedObstruction[createIndexSyntax(
              [currentPosition[0], currentPosition[1] + 1])] = true;
          map[currentPosition[0]][currentPosition[1] + 1] = obstruction;
          currentPosition[2] = 2;
          break;
        case 2:
          map[currentPosition[0]][currentPosition[1]] = '<';
          if ("^" == map[currentPosition[0] + 1][currentPosition[1]]) {
            break;
          }
          if (placedObstruction.containsKey(createIndexSyntax(
              [currentPosition[0] + 1, currentPosition[1]]))) {
            currentPosition = fullPath.removeAt(0);
            if (currentPosition == startPosition) {
              currentPosition = fullPath.removeAt(0);
            }
            continue;
          }
          placedObstruction[createIndexSyntax(
              [currentPosition[0] + 1, currentPosition[1]])] = true;
          map[currentPosition[0] + 1][currentPosition[1]] = obstruction;
          currentPosition[2] = 3;
          break;
        case 3:
          map[currentPosition[0]][currentPosition[1]] = '^';
          if ("^" == map[currentPosition[0]][currentPosition[1] - 1]) {
            break;
          }
          if (placedObstruction.containsKey(createIndexSyntax(
              [currentPosition[0], currentPosition[1] - 1]))) {
            currentPosition = fullPath.removeAt(0);
            if (currentPosition == startPosition) {
              currentPosition = fullPath.removeAt(0);
            }
            continue;
          }
          placedObstruction[createIndexSyntax(
              [currentPosition[0], currentPosition[1] - 1])] = true;
          map[currentPosition[0]][currentPosition[1] - 1] = obstruction;
          currentPosition[2] = 0;
          break;
      }
    } catch (e) {}
    traverseMap(map, currentPosition, {}, loops, pathsTaken);
    currentPosition = fullPath.removeAt(0);
    if (currentPosition == startPosition) {
      currentPosition = fullPath.removeAt(0);
    }
  }

  print('\n⭐ Part B Result: ${loops.keys.length} \n');
}

String createIndexSyntax(List<int> currentPositon) {
  return "${currentPositon[0]},${currentPositon[1]}";
}

String createPathKey(List<List<int>> path) {
  var loop = path.map(createIndexSyntax).toList();
  loop.sort();
  return loop.join('|');
}

List<List<int>> traverseMap(
    List<List<String>> map,
    List<int> currentPosition,
    Map<String, int> visitedPositions,
    Map<String, int> loops,
    Map<String, bool> pathsTaken) {
  List<List<int>> path = [];
  var count = 0;
  movementLoop:
  while (true) {
    count++;
    if (count > 10000) {
      loops[Uuid().v4()] = 1;
      break movementLoop;
    }
    if (path.length > 2) {
      path.removeAt(path.length - 1);
    }

    switch (currentPosition[2]) {
      case 2: // down
        for (currentPosition[0]; true; currentPosition[0]++) {
          if (map.length == currentPosition[0]) {
            break movementLoop;
          }
          if (obstruction == map[currentPosition[0]][currentPosition[1]]) {
            currentPosition[0]--;
            currentPosition[2] = 3;
            break;
          }
          path.add(List.from(currentPosition));
          var key = createIndexSyntax(currentPosition);
          visitedPositions[key] = visitedPositions.containsKey(key)
              ? visitedPositions[key]! + 1
              : 0;
        }
        continue;
      case 1: // right
        for (currentPosition[1]; true; currentPosition[1]++) {
          if (map[0].length == currentPosition[1]) {
            break movementLoop;
          }
          if (obstruction == map[currentPosition[0]][currentPosition[1]]) {
            currentPosition[1]--;
            currentPosition[2] = 2;
            break;
          }
          path.add(List.from(currentPosition));
          var key = createIndexSyntax(currentPosition);
          visitedPositions[key] = visitedPositions.containsKey(key)
              ? visitedPositions[key]! + 1
              : 0;
        }
        continue;
      case 0: // up
        for (currentPosition[0]; true; currentPosition[0]--) {
          if (-1 == currentPosition[0]) {
            break movementLoop;
          }
          if (obstruction == map[currentPosition[0]][currentPosition[1]]) {
            currentPosition[0]++;
            currentPosition[2] = 1;
            break;
          }
          path.add(List.from(currentPosition));
          var key = createIndexSyntax(currentPosition);
          visitedPositions[key] = visitedPositions.containsKey(key)
              ? visitedPositions[key]! + 1
              : 0;
        }
        continue;
      case 3: // left
        for (currentPosition[1]; true; currentPosition[1]--) {
          if (-1 == currentPosition[1]) {
            break movementLoop;
          }
          if (obstruction == map[currentPosition[0]][currentPosition[1]]) {
            currentPosition[1]++;
            currentPosition[2] = 0;
            break;
          }
          path.add(List.from(currentPosition));
          var key = createIndexSyntax(currentPosition);
          visitedPositions[key] = visitedPositions.containsKey(key)
              ? visitedPositions[key]! + 1
              : 0;
        }
        continue;
    }
  }
  return path;
}

void print2DArray<T>(List<T> array) {
  for (var item in array) {
    print(item);
  }
  print("\n");
}
