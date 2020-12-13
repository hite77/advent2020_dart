import 'dart:convert';
import 'dart:core';
import 'dart:io';

List<String> map = [];
List<String> nextState = [];

addLine(line) {
  map.add(line);
}

int countOrZeroOutside(x, y, dirx, diry) {
  var value = 0;
  var i = x + dirx;
  var j = y + diry;

  // need to keep going in straight lines, if you encounter a L then 0
  // keep moving dirx and diry
  // or stepping out...

  while (i >= 0 && i < map.length && j >= 0 && j < map[0].length) {
    if (map[i][j] == '#') {
      value = 1;
      break;
    }

    if (map[i][j] == 'L') {
      value = 0;
      break;
    }
    i += dirx;
    j += diry;
  }
  return value;
}

int countOfSeatsAround(i, j) {
  return countOrZeroOutside(i, j, -1, -1) + // -1, -1
      countOrZeroOutside(i, j, -1, 0) + // -1, 0
      countOrZeroOutside(i, j, -1, 1) + // -1, +1
      countOrZeroOutside(i, j, 0, -1) + // 0, -1
      countOrZeroOutside(i, j, 0, 1) + //0, +1
      countOrZeroOutside(i, j, 1, -1) + // 1, -1
      countOrZeroOutside(i, j, 1, 0) + // 1, 0
      countOrZeroOutside(i, j, 1, 1); // 1, 1
}

//If a seat is empty (L) and there are no occupied seats adjacent to it, the seat becomes occupied.
//If a seat is occupied (#) and four or more seats adjacent to it are also occupied, the seat becomes empty.
//Otherwise, the seat's state does not change.

// morePlanets = new List<String>.from(planets)
round() {
  // updates using rules above....
  nextState = []; //new List<String>.from(map);
  for (var i = 0; i < map.length; i++) {
    String newLine = '';
    for (var j = 0; j < map[i].length; j++) {
      var count = countOfSeatsAround(i, j);
      if (map[i][j] == 'L' && count == 0) {
        newLine += '#';
      } else if (map[i][j] == '#' && count > 4) {
        newLine += 'L';
      } else {
        newLine += map[i][j];
      }
    }
    nextState.add(newLine);
  }
  map = new List<String>.from(nextState);
}

bool compare(map1, map2) {
  var cont = false;
  for (int i = 0; i < map1.length; i++) {
    for (int j = 0; j < map1[i].length; j++) {
      if (map1[i][j] != map2[i][j]) {
        cont = true;
        break;
      }
    }
  }
  return cont;
}

int answer() {
  // repeatedly call round until no changes, then count how many occupied..
  int answer = 0;
  List current = [];
  do {
    current = new List<String>.from(map);
    round();
  } while (compare(map, current));
  print(map);
  for (int i = 0; i < map.length; i++) {
    for (int j = 0; j < map[i].length; j++) {
      if (map[i][j] == '#') {
        answer += 1;
      }
    }
  }

  return answer;
}

//todo: can I integration test the whole thing?
void main() async {
  print('adapter array');
  var file = File('data.txt');
  if (await file.exists()) {
    var contentStream = file.openRead();
    contentStream.transform(Utf8Decoder()).transform(LineSplitter()).listen(
        (String line) => addLine(line),
        onDone: () =>
            print('Answer:${answer()}'), // part2: ${all_answer_count()}'),
        onError: (e) => print('$e'));
  }
}
