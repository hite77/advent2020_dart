import 'dart:convert';
import 'dart:core';
import 'dart:io';

class coord {
  int x = 0, y = 0;

  bool operator ==(o) => o is coord && o.x == x && o.y == y;
}

//coords are tiles that are white
List<coord> coords = [];

//e, se, sw, w, nw, and ne
readLine(String line) {
  coord current = new coord();
  current.x = 0;
  current.y = 0;
  while (line.isNotEmpty) {
    //check if character is e or w
    String direction = line.substring(0, 1);
    if (direction == 'e' || direction == 'w') {
      line = line.substring(1);
    } else {
      direction = line.substring(0, 2);
      line = line.substring(2);
    }
    // use direction to move coords
    // e, se, sw, w, nw, and ne
    if (direction == 'e') {
      current.x = current.x + 2;
    } else if (direction == 'se') {
      current.x = current.x + 1;
      current.y = current.y + 1;
    } else if (direction == 'sw') {
      current.x = current.x - 1;
      current.y = current.y + 1;
    } else if (direction == 'w') {
      current.x = current.x - 2;
    } else if (direction == 'nw') {
      current.x = current.x - 1;
      current.y = current.y - 1;
    } else if (direction == 'ne') {
      current.x = current.x + 1;
      current.y = current.y - 1;
    }
  }
  // check if coordinate in first
  // print('coord: ${current.x} , ${current.y}');
  if (coords.contains(current)) {
    coords.remove(current);
  } else {
    coords.add(current);
  }
}

int answer() {
  return coords.length;
}

int day(int d) {
  return 42;
}

String answer2() {
  // Any black tile with zero or more than 2 black tiles immediately adjacent to it is flipped to white.
  // Any white tile with exactly 2 black tiles immediately adjacent to it is flipped to black.

  // 100 days...

  return 'bar';
}

void main() async {
  var file = File('data.txt');
  if (await file.exists()) {
    var contentStream = file.openRead();
    contentStream.transform(Utf8Decoder()).transform(LineSplitter()).listen(
        (String line) => readLine(line),
        onDone: () => print('Answer: ${answer()} Answer2: ${answer2()}'),
        onError: (e) => print('$e'));
  }
}
