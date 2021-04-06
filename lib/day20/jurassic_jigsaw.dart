import 'dart:convert';
import 'dart:core';
import 'dart:io';

Map<int, List<String>> pictures = new Map();
int currentId;
List<String> currentMap = [];
Map<int, List<int>> connections = new Map();
List<List<int>> board = [];
List<List<String>> screen = [];

void readLine(String line) {
  // print('Line: $line');
  // ignore blank lines...
  if (line == '') {
    currentMap = [];
    return;
  }

  // Tile 1091:
  RegExp exp = new RegExp(r"^Tile ([0-9]+):$");
  Iterable<Match> matches = exp.allMatches(line);
  if (matches.length > 0) {
    currentId = int.parse(matches.elementAt(0).group(1));
    pictures[currentId] = currentMap;
  } else {
    currentMap.add(line);
    pictures[currentId] = currentMap;
  }
}

String grabTop(id) {
  return pictures[id][0];
}

String grabBottom(id) {
  return pictures[id][9];
}

String grabRight(id) {
  return pictures[id][0].substring(9) +
      pictures[id][1].substring(9) +
      pictures[id][2].substring(9) +
      pictures[id][3].substring(9) +
      pictures[id][4].substring(9) +
      pictures[id][5].substring(9) +
      pictures[id][6].substring(9) +
      pictures[id][7].substring(9) +
      pictures[id][8].substring(9) +
      pictures[id][9].substring(9);
}

String grabLeft(id) {
  return pictures[id][0].substring(0, 1) +
      pictures[id][1].substring(0, 1) +
      pictures[id][2].substring(0, 1) +
      pictures[id][3].substring(0, 1) +
      pictures[id][4].substring(0, 1) +
      pictures[id][5].substring(0, 1) +
      pictures[id][6].substring(0, 1) +
      pictures[id][7].substring(0, 1) +
      pictures[id][8].substring(0, 1) +
      pictures[id][9].substring(0, 1);
}

void add(id1, id2) {
  if (connections[id1] == null) {
    connections[id1] = [];
  }
  if (connections[id2] == null) {
    connections[id2] = [];
  }
  if (!connections[id1].contains(id2)) {
    connections[id1].add(id2);
  }
  if (!connections[id2].contains(id1)) {
    connections[id2].add(id1);
  }
}

bool compareEdgeToPiece(String side, int id) {
  var top = pictures[id][0];
  var bottom = pictures[id][9];
  var left = grabLeft(id);
  var right = grabRight(id);

  if ((side == top || side == top.split('').reversed.join()) ||
      (side == bottom || side == bottom.split('').reversed.join()) ||
      (side == left || side == left.split('').reversed.join()) ||
      (side == right || side == right.split('').reversed.join())) {
    return true;
  } else {
    return false;
  }
}

int compareTilesEdges(id1, id2) {
  // need to return how many matches between pieces...
  var matches = 0;
  // top to all sides...
  var top1 = pictures[id1][0];
  var right1 = grabRight(id1);
  var bottom1 = pictures[id1][9];
  var left1 = grabLeft(id1);

  var top2 = pictures[id2][0];
  var right2 = grabRight(id2);
  var bottom2 = pictures[id2][9];
  var left2 = grabLeft(id2);

  if ((top1 == top2) || ((top1 == top2.split('').reversed.join()))) {
    matches = matches + 1;
    add(id1, id2);
  }
  if ((top1 == right2) || (top1 == (right2.split('').reversed.join()))) {
    matches = matches + 1;
    add(id1, id2);
  }
  if ((top1 == bottom2) || (top1 == (bottom2.split('').reversed.join()))) {
    matches = matches + 1;
    add(id1, id2);
  }
  if ((top1 == left2) || (top1 == (left2.split('').reversed.join()))) {
    matches = matches + 1;
    add(id1, id2);
  }

  if ((right1 == top2) || ((right1 == top2.split('').reversed.join()))) {
    matches = matches + 1;
    add(id1, id2);
  }
  if ((right1 == right2) || (right1 == (right2.split('').reversed.join()))) {
    matches = matches + 1;
    add(id1, id2);
  }
  if ((right1 == bottom2) || (right1 == (bottom2.split('').reversed.join()))) {
    matches = matches + 1;
    add(id1, id2);
  }
  if ((right1 == left2) || (right1 == (left2.split('').reversed.join()))) {
    matches = matches + 1;
    add(id1, id2);
  }

  if ((bottom1 == top2) || (bottom1 == (top2.split('').reversed.join()))) {
    matches = matches + 1;
    add(id1, id2);
  }
  if ((bottom1 == right2) || (bottom1 == (right2.split('').reversed.join()))) {
    matches = matches + 1;
    add(id1, id2);
  }
  if ((bottom1 == bottom2) ||
      (bottom1 == (bottom2.split('').reversed.join()))) {
    matches = matches + 1;
    add(id1, id2);
  }
  if ((bottom1 == left2) || (bottom1 == (left2.split('').reversed.join()))) {
    matches = matches + 1;
    add(id1, id2);
  }

  if ((left1 == top2) || (left1 == (top2.split('').reversed.join()))) {
    matches = matches + 1;
    add(id1, id2);
  }
  if ((left1 == right2) || (left1 == (right2.split('').reversed.join()))) {
    matches = matches + 1;
    add(id1, id2);
  }
  if ((left1 == bottom2) || (left1 == (bottom2.split('').reversed.join()))) {
    matches = matches + 1;
    add(id1, id2);
  }
  if ((left1 == left2) || (left1 == (left2.split('').reversed.join()))) {
    matches = matches + 1;
    add(id1, id2);
  }

  // if (matches != 0) {
  //   print('matches:$matches');
  // }
  return matches;
}

bool findTwoSidesNonMatching(id) {
  // if three match stop looking.... return false
  // if only two return true....
  var countMatching = 0;
  pictures.keys.forEach((element) {
    if ((element < id) || (element > id)) {
      countMatching = countMatching + compareTilesEdges(id, element);
    }
  });
  print('id: $id countMatching:$countMatching picture:${pictures[id]}');
  if (countMatching == 2) {
    return true;
  }
  return false;
}

int answer() {
  List corners = [];

  pictures.keys.forEach((element) {
    if (findTwoSidesNonMatching(element)) {
      // print('element:$element is corner');
      corners.add(element);
    } else {
      // print('element:$element is not a corner');
    }
  });

  print('corners: $corners');
  print('connections: $connections');
  print('tiles: ${pictures.keys.length}');
  var answer = 0;

  if (corners.length == 4) {
    answer = corners.first;
    print('element: $answer pic: ${pictures[answer]}');
    corners.remove(answer);
    corners.forEach((element) {
      print('element: $element pic: ${pictures[element]}');
      answer *= element;
    });
  }

  return answer;
}

//todo: need to rotate left... not sure if this works or not?
rotateScreenLeft() {
  List<List<String>> rotated =
      List.generate(screen.length, (i) => List(screen.length), growable: false);
  int size = rotated.length;
  // [current_position][i] = [][size-current_position]
  // [0][0] = [0][2] = 2
  // [0][1] = [1][2] = X
  // [0][2] = [2][2] = 3
  // [1][0] = [0][1]
  // [1][1] = [1][1]
  // [1][2] = [2][1]
  // [2][0] = [0][0] = 1
  // [2][1] = [1][0] = X
  // [2][2] = [2][0] = 4

  for (var current_position = 0; current_position < size; current_position++) {
    for (var i = 0; i < size; i++) {
      rotated[current_position][i] = screen[i][size - 1 - current_position];
    }
  }
  screen = rotated;
}

flipScreenLeft() {
  List<List<String>> flipped = List.from(screen);
  for (var y = 0; y < flipped.length; y++) {
    for (var x = 0; x < flipped.length; x++) {
      flipped[y][x] = screen[y][flipped.length - 1 - x];
    }
  }
  screen = flipped;
}

rotateLeft(id) {
  List<String> rotated = [];

  rotated.add(pictures[id][0].substring(9) +
      pictures[id][1].substring(9) +
      pictures[id][2].substring(9) +
      pictures[id][3].substring(9) +
      pictures[id][4].substring(9) +
      pictures[id][5].substring(9) +
      pictures[id][6].substring(9) +
      pictures[id][7].substring(9) +
      pictures[id][8].substring(9) +
      pictures[id][9].substring(9));
  rotated.add(pictures[id][0].substring(8, 9) +
      pictures[id][1].substring(8, 9) +
      pictures[id][2].substring(8, 9) +
      pictures[id][3].substring(8, 9) +
      pictures[id][4].substring(8, 9) +
      pictures[id][5].substring(8, 9) +
      pictures[id][6].substring(8, 9) +
      pictures[id][7].substring(8, 9) +
      pictures[id][8].substring(8, 9) +
      pictures[id][9].substring(8, 9));
  rotated.add(pictures[id][0].substring(7, 8) +
      pictures[id][1].substring(7, 8) +
      pictures[id][2].substring(7, 8) +
      pictures[id][3].substring(7, 8) +
      pictures[id][4].substring(7, 8) +
      pictures[id][5].substring(7, 8) +
      pictures[id][6].substring(7, 8) +
      pictures[id][7].substring(7, 8) +
      pictures[id][8].substring(7, 8) +
      pictures[id][9].substring(7, 8));
  rotated.add(pictures[id][0].substring(6, 7) +
      pictures[id][1].substring(6, 7) +
      pictures[id][2].substring(6, 7) +
      pictures[id][3].substring(6, 7) +
      pictures[id][4].substring(6, 7) +
      pictures[id][5].substring(6, 7) +
      pictures[id][6].substring(6, 7) +
      pictures[id][7].substring(6, 7) +
      pictures[id][8].substring(6, 7) +
      pictures[id][9].substring(6, 7));
  rotated.add(pictures[id][0].substring(5, 6) +
      pictures[id][1].substring(5, 6) +
      pictures[id][2].substring(5, 6) +
      pictures[id][3].substring(5, 6) +
      pictures[id][4].substring(5, 6) +
      pictures[id][5].substring(5, 6) +
      pictures[id][6].substring(5, 6) +
      pictures[id][7].substring(5, 6) +
      pictures[id][8].substring(5, 6) +
      pictures[id][9].substring(5, 6));
  rotated.add(pictures[id][0].substring(4, 5) +
      pictures[id][1].substring(4, 5) +
      pictures[id][2].substring(4, 5) +
      pictures[id][3].substring(4, 5) +
      pictures[id][4].substring(4, 5) +
      pictures[id][5].substring(4, 5) +
      pictures[id][6].substring(4, 5) +
      pictures[id][7].substring(4, 5) +
      pictures[id][8].substring(4, 5) +
      pictures[id][9].substring(4, 5));
  rotated.add(pictures[id][0].substring(3, 4) +
      pictures[id][1].substring(3, 4) +
      pictures[id][2].substring(3, 4) +
      pictures[id][3].substring(3, 4) +
      pictures[id][4].substring(3, 4) +
      pictures[id][5].substring(3, 4) +
      pictures[id][6].substring(3, 4) +
      pictures[id][7].substring(3, 4) +
      pictures[id][8].substring(3, 4) +
      pictures[id][9].substring(3, 4));
  rotated.add(pictures[id][0].substring(2, 3) +
      pictures[id][1].substring(2, 3) +
      pictures[id][2].substring(2, 3) +
      pictures[id][3].substring(2, 3) +
      pictures[id][4].substring(2, 3) +
      pictures[id][5].substring(2, 3) +
      pictures[id][6].substring(2, 3) +
      pictures[id][7].substring(2, 3) +
      pictures[id][8].substring(2, 3) +
      pictures[id][9].substring(2, 3));
  rotated.add(pictures[id][0].substring(1, 2) +
      pictures[id][1].substring(1, 2) +
      pictures[id][2].substring(1, 2) +
      pictures[id][3].substring(1, 2) +
      pictures[id][4].substring(1, 2) +
      pictures[id][5].substring(1, 2) +
      pictures[id][6].substring(1, 2) +
      pictures[id][7].substring(1, 2) +
      pictures[id][8].substring(1, 2) +
      pictures[id][9].substring(1, 2));
  rotated.add(pictures[id][0].substring(0, 1) +
      pictures[id][1].substring(0, 1) +
      pictures[id][2].substring(0, 1) +
      pictures[id][3].substring(0, 1) +
      pictures[id][4].substring(0, 1) +
      pictures[id][5].substring(0, 1) +
      pictures[id][6].substring(0, 1) +
      pictures[id][7].substring(0, 1) +
      pictures[id][8].substring(0, 1) +
      pictures[id][9].substring(0, 1));
  pictures[id] = rotated;
}

flipHorizontal(id) {
  // flip all backwards
  List<String> backwards = [];
  pictures[id].forEach((element) {
    backwards.add(element.split('').reversed.join());
  });
  pictures[id] = backwards;
}

changeState(int count, int id) {
  rotateLeft(id);
  if (count == 4 || count == 8) {
    flipHorizontal(id);
  }
}

changeStateScreen(int count) {
  rotateScreenLeft();
  if (count == 4 || count == 8) {
    flipScreenLeft();
  }
}

containedIn(String side, id) {
  if ((side == grabBottom(id)) ||
      (side == (grabBottom(id).split('').reversed.join())) ||
      (side == grabTop(id)) ||
      (side == (grabTop(id).split('').reversed.join())) ||
      (side == grabLeft(id)) ||
      (side == (grabLeft(id).split('').reversed.join())) ||
      (side == grabRight(id)) ||
      (side == (grabRight(id).split('').reversed.join()))) {
    return true;
  }
  return false;
}

int answer2() {
  // tried 5060, and did not work...
  // tried 2582 still too high....
  // tried 2459 still too high....
  // correct: 2129

  List corners = [];
  pictures.keys.forEach((element) {
    if (findTwoSidesNonMatching(element)) {
      // print('element:$element is corner');
      corners.add(element);
    }
  });

  // pick a corner and orient so that right and bottom are shared....
  List<int> row = [corners.first];
  var connected = connections[corners.first];

  int rotateCorner = 0;
  int square0 = 0;
  int square1 = 0;

  while (!notAlignedTopCorner(corners.first, connected[0], connected[1])) {
    if (rotateCorner < 7) {
      rotateCorner += 1;
      changeState(rotateCorner, corners.first);
    } else {
      rotateCorner += 1;
      changeState(rotateCorner, corners.first);
      rotateCorner = 0;
      if (square0 < 7) {
        square0 += 1;
        changeState(square0, connected[0]);
      } else {
        square0 += 0;
        changeState(square0, connected[0]);
        square0 = 0;
        if (square1 < 7) {
          square1 += 1;
          changeState(square1, connected[1]);
        } else {
          square1 += 1;
          changeState(square1, connected[1]);
        }
      }
    }
  }

  List<int> topRow = [corners.first];
  if (grabRight(corners.first) == connected[0]) {
    topRow.add(connected[0]);
  } else {
    topRow.add(connected[1]);
  }

  collectRow(topRow, corners);
  board.add(topRow);

  while (board.length == 1 || !corners.contains(board.last.first)) {
    List<int> row = [];
    connections[board.last.first].forEach((element) {
      if (compareEdgeToPiece(grabBottom(board.last.first), element)) {
        row.add(element);
        rotateToMatchTop(grabBottom(board.last.first), element);
        collectRow(row, corners);
        board.add(row);
      }
    });
  }

  print('Board');
  print(board);

  // need to cut borders and fuse it together....
  fillCells(board.first.length, board.length, screen);
  // need to cut left, right, top bottom from pictures

  pictures.keys.forEach((element) {
    List<String> cut = [];
    for (var y = 1; y < 9; y++) {
      cut.add(pictures[element][y].substring(1, 9));
    }
    pictures[element] = cut;
  });

  for (var y = 0; y < board.length; y++) {
    for (var x = 0; x < board.first.length; x++) {
      copyCells(board[y][x], x, y);
    }
  }
  print('screen:');
  screen.forEach((element) {
    print(element);
  });

  int position = 0;
  int lowest = countMonster();
  while (position < 9) {
    changeStateScreen(position);
    int current = countMonster();
    if (current < lowest) {
      lowest = current;
    }
    print('Screen');
    screen.forEach((element) {
      print(element);
    });
    // print(screen);
    position += 1;
  }
  return lowest;
}

int countMonster() {
  List<String> monster = [
    '.#...#.###...#.##.O#',
    'O.##.OO#.#.OO.##.OOO',
    '#O.#O#.O##O..O.#O##.'
  ];

  int count = 0;
  // convert monster to O -- then count # and return count....
  for (var y = 0; y < (screen.length - monster.length); y++) {
    for (var x = 0; x < (screen.first.length - monster.first.length); x++) {
      bool foundAll = true;
      for (var ymonster = 0; ymonster < monster.length; ymonster++) {
        for (var xmonster = 0; xmonster < monster.first.length; xmonster++) {
          if (monster[ymonster][xmonster] == 'O') {
            if (screen[y + ymonster][x + xmonster] == '#' ||
                screen[y + ymonster][x + xmonster] == 'O') {
              foundAll = foundAll & true;
            } else {
              foundAll = false;
            }
          }
        }
      }
      if (foundAll) {
        for (var ymonster = 0; ymonster < monster.length; ymonster++) {
          for (var xmonster = 0; xmonster < monster.first.length; xmonster++) {
            if (monster[ymonster][xmonster] == 'O') {
              screen[y + ymonster][x + xmonster] = 'O';
            }
          }
        }
      }
    }
  }

  for (var y = 0; y < screen.length; y++) {
    for (var x = 0; x < screen.first.length; x++) {
      if (screen[y][x] == '#') {
        count += 1;
      }
    }
  }

  // change O back to # at end
  for (var y = 0; y < screen.length; y++) {
    for (var x = 0; x < screen.first.length; x++) {
      if (screen[y][x] == 'O') {
        screen[y][x] = '#';
      }
    }
  }
  return count;
}

void fillCells(int widthEights, int heightEights, screen) {
  for (var i = 1; i <= heightEights * 8; i++) {
    List<String> empty = [];
    for (var i = 1; i <= widthEights; i++) {
      empty.add('1');
      empty.add('2');
      empty.add('3');
      empty.add('4');
      empty.add('5');
      empty.add('6');
      empty.add('7');
      empty.add('8');
    }
    screen.add(empty);
  }
}

void copyCells(int id, int offset_x, int offset_y) {
  // pictures id --> x 0 --> 9, y 0 --> 9
  // to screen offset offset_x*10 , offset_y*10 + x,y
  for (var x = 0; x < 8; x++) {
    for (var y = 0; y < 8; y++) {
      if (x < 7) {
        screen[(offset_y * 8) + y][(offset_x * 8) + x] =
            pictures[id][y].substring(x, x + 1);
      } else {
        screen[(offset_y * 8) + y][(offset_x * 8) + x] =
            pictures[id][y].substring(x);
      }
    }
  }
}

void collectRow(List<int> row, List corners) {
  int countAdded = 1;
  while (countAdded > 0) {
    countAdded = 0;
    connections[row.last].forEach((element) {
      if (compareEdgeToPiece(grabRight(row.last), element)) {
        rotateToMatchRight(grabRight(row.last), element);
        row.add(element);
        countAdded += 1;
      }
    });
  }
}

void rotateToMatchTop(String top, int element) {
  int rotation = 0;
  while (top != grabTop(element)) {
    rotation += 1;
    changeState(rotation, element);
  }
  print('rotation:');
  print(rotation);
}

void rotateToMatchRight(String right, int element) {
  int rotation = 0;
  while (right != grabLeft(element)) {
    rotation += 1;
    changeState(rotation, element);
  }
  print('rotation:');
  print(rotation);
}

bool notAlignedTopCorner(corner, position1, position2) {
  if ((grabBottom(corner) == grabTop(position1) &&
          grabRight(corner) == grabLeft(position2)) ||
      (grabBottom(corner) == grabTop(position1) &&
          grabRight(corner) == grabLeft(position2))) {
    return true;
  } else {
    return false;
  }
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
