import 'dart:convert';
import 'dart:core';
import 'dart:io';

Map<int, List<String>> pictures = new Map();
int currentId;
List<String> currentMap = [];
Map<int, List<int>> connections = new Map();

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
  List corners = [];
  List<List<int>> arrangements = [];
  var currentx = 0;
  var currenty = 0;
  // var goingDown = true;
  var squaresDone = 0;
  var toBeDone = pictures.keys.length;

  pictures.keys.forEach((element) {
    if (findTwoSidesNonMatching(element)) {
      // print('element:$element is corner');
      corners.add(element);
    }
  });

  // pick a corner and orient so that right and bottom are shared....
  List<int> row = [corners.first];
  var connected = connections[corners.first];

  var bottomMatches = ((grabBottom(corners.first) == grabTop(connected[0])) ||
      (grabBottom(corners.first) == grabTop(connected[1])));
  var rightMatches = ((grabRight(corners.first) == grabLeft(connected[0])) ||
      ((grabRight(corners.first) == grabLeft(connected[1]))));
  while (!(bottomMatches && rightMatches)) {
    while (!containedIn(grabBottom(corners.first), connected[0]) &&
        !containedIn(grabRight(corners.first), connected[1])) {
      print('rotate');
      rotateLeft(corners.first);
    }
    bottomMatches = ((grabBottom(corners.first) == grabTop(connected[0])) ||
        (grabBottom(corners.first) == grabTop(connected[1])));
    rightMatches = ((grabRight(corners.first) == grabLeft(connected[0])) ||
        ((grabRight(corners.first) == grabLeft(connected[1]))));
    if (!(bottomMatches && rightMatches)) {
      flipHorizontal(corners.first);
      bottomMatches = ((grabBottom(corners.first) == grabTop(connected[0])) ||
          (grabBottom(corners.first) == grabTop(connected[1])));
      rightMatches = ((grabRight(corners.first) == grabLeft(connected[0])) ||
          ((grabRight(corners.first) == grabLeft(connected[1]))));
      print('flip');
    }
  }

  // I could find matches related to square.... and rotate them....
  // square above, should have bottom match...
  // bottom square move right, top square move right....
  // keep going till all squares assigned...

  // Note: could build a map that indicates which id's touch....
  // may have to rotate, and determine which are left/right/top/bottom

  // need to cut borders and fuse it together....
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
