import 'dart:convert';
import 'dart:core';
import 'dart:io';

// make four dimensions....

List<List<List<List<bool>>>> items = [];

var lineRead = 0;

int activeInbounds(int x, int y, int z, int w) {
  if (x < 0 ||
      y < 0 ||
      z < 0 ||
      w < 0 ||
      x >= items.length ||
      y >= items[0].length ||
      z >= items[0][0].length ||
      w >= items[0][0][0].length) {
    return 0;
  }
  if (items[x][y][z][w]) {
    return 1;
  }
  return 0;
}

List<List<List<List<bool>>>> copy(List<List<List<List<bool>>>> source) {
  List<List<List<List<bool>>>> destination = [];
  for (int x = 0; x < source.length; x++) {
    List<List<List<bool>>> something = [];
    for (int y = 0; y < source[0].length; y++) {
      List<List<bool>> pane = [];
      for (int z = 0; z < source[0][0].length; z++) {
        List<bool> line = [];
        for (int w = 0; w < source[0][0][0].length; w++) {
          line.add(source[x][y][z][w]);
        }
        // destination[x][y][z] = source[x][y][z];
        pane.add(line);
      }
      // add List
      something.add(pane);
    }
    // add List of List
    destination.add(something);
  }
  return destination;
}

// 3d count, without counting outside ranges...
int countOfCubes(int x, int y, int z, int w) {
  // count in items, update nextState
  var count = 0;
  count += activeInbounds(x - 1, y - 1, z - 1, w - 1); // 1
  count += activeInbounds(x, y - 1, z - 1, w - 1); // 2
  count += activeInbounds(x + 1, y - 1, z - 1, w - 1); // 3
  count += activeInbounds(x - 1, y, z - 1, w - 1); // 4
  count += activeInbounds(x, y, z - 1, w - 1); // 5
  count += activeInbounds(x + 1, y, z - 1, w - 1); // 6
  count += activeInbounds(x - 1, y + 1, z - 1, w - 1); // 7
  count += activeInbounds(x, y + 1, z - 1, w - 1); // 8
  count += activeInbounds(x + 1, y + 1, z - 1, w - 1); // 9
  count += activeInbounds(x - 1, y - 1, z, w - 1); // 10
  count += activeInbounds(x, y - 1, z, w - 1); // 11
  count += activeInbounds(x + 1, y - 1, z, w - 1); // 12
  count += activeInbounds(x - 1, y, z, w - 1); // 13
  count += activeInbounds(x, y, z, w - 1); // 14
  count += activeInbounds(x + 1, y, z, w - 1); // 14
  count += activeInbounds(x - 1, y + 1, z, w - 1); // 15
  count += activeInbounds(x, y + 1, z, w - 1); // 16
  count += activeInbounds(x + 1, y + 1, z, w - 1); // 17
  count += activeInbounds(x - 1, y - 1, z + 1, w - 1); // 18
  count += activeInbounds(x, y - 1, z + 1, w - 1); // 19
  count += activeInbounds(x + 1, y - 1, z + 1, w - 1); // 20
  count += activeInbounds(x - 1, y, z + 1, w - 1); // 21
  count += activeInbounds(x, y, z + 1, w - 1); // 22
  count += activeInbounds(x + 1, y, z + 1, w - 1); // 23
  count += activeInbounds(x - 1, y + 1, z + 1, w - 1); // 24
  count += activeInbounds(x, y + 1, z + 1, w - 1); // 25
  count += activeInbounds(x + 1, y + 1, z + 1, w - 1); // 26

  count += activeInbounds(x - 1, y - 1, z - 1, w); // 1
  count += activeInbounds(x, y - 1, z - 1, w); // 2
  count += activeInbounds(x + 1, y - 1, z - 1, w); // 3
  count += activeInbounds(x - 1, y, z - 1, w); // 4
  count += activeInbounds(x, y, z - 1, w); // 5
  count += activeInbounds(x + 1, y, z - 1, w); // 6
  count += activeInbounds(x - 1, y + 1, z - 1, w); // 7
  count += activeInbounds(x, y + 1, z - 1, w); // 8
  count += activeInbounds(x + 1, y + 1, z - 1, w); // 9
  count += activeInbounds(x - 1, y - 1, z, w); // 10
  count += activeInbounds(x, y - 1, z, w); // 11
  count += activeInbounds(x + 1, y - 1, z, w); // 12
  count += activeInbounds(x - 1, y, z, w); // 13
  count += activeInbounds(x + 1, y, z, w); // 14
  count += activeInbounds(x - 1, y + 1, z, w); // 15
  count += activeInbounds(x, y + 1, z, w); // 16
  count += activeInbounds(x + 1, y + 1, z, w); // 17
  count += activeInbounds(x - 1, y - 1, z + 1, w); // 18
  count += activeInbounds(x, y - 1, z + 1, w); // 19
  count += activeInbounds(x + 1, y - 1, z + 1, w); // 20
  count += activeInbounds(x - 1, y, z + 1, w); // 21
  count += activeInbounds(x, y, z + 1, w); // 22
  count += activeInbounds(x + 1, y, z + 1, w); // 23
  count += activeInbounds(x - 1, y + 1, z + 1, w); // 24
  count += activeInbounds(x, y + 1, z + 1, w); // 25
  count += activeInbounds(x + 1, y + 1, z + 1, w); // 26

  count += activeInbounds(x - 1, y - 1, z - 1, w + 1); // 1
  count += activeInbounds(x, y - 1, z - 1, w + 1); // 2
  count += activeInbounds(x + 1, y - 1, z - 1, w + 1); // 3
  count += activeInbounds(x - 1, y, z - 1, w + 1); // 4
  count += activeInbounds(x, y, z - 1, w + 1); // 5
  count += activeInbounds(x + 1, y, z - 1, w + 1); // 6
  count += activeInbounds(x - 1, y + 1, z - 1, w + 1); // 7
  count += activeInbounds(x, y + 1, z - 1, w + 1); // 8
  count += activeInbounds(x + 1, y + 1, z - 1, w + 1); // 9
  count += activeInbounds(x - 1, y - 1, z, w + 1); // 10
  count += activeInbounds(x, y - 1, z, w + 1); // 11
  count += activeInbounds(x + 1, y - 1, z, w + 1); // 12
  count += activeInbounds(x - 1, y, z, w + 1); // 13
  count += activeInbounds(x, y, z, w + 1); // 14
  count += activeInbounds(x + 1, y, z, w + 1); // 14
  count += activeInbounds(x - 1, y + 1, z, w + 1); // 15
  count += activeInbounds(x, y + 1, z, w + 1); // 16
  count += activeInbounds(x + 1, y + 1, z, w + 1); // 17
  count += activeInbounds(x - 1, y - 1, z + 1, w + 1); // 18
  count += activeInbounds(x, y - 1, z + 1, w + 1); // 19
  count += activeInbounds(x + 1, y - 1, z + 1, w + 1); // 20
  count += activeInbounds(x - 1, y, z + 1, w + 1); // 21
  count += activeInbounds(x, y, z + 1, w + 1); // 22
  count += activeInbounds(x + 1, y, z + 1, w + 1); // 23
  count += activeInbounds(x - 1, y + 1, z + 1, w + 1); // 24
  count += activeInbounds(x, y + 1, z + 1, w + 1); // 25
  count += activeInbounds(x + 1, y + 1, z + 1, w + 1); // 26

  return count;
}

void applyRules() {
  var nextState = copy(items);
  // count in items, update nextState
  for (int x = 0; x < items.length; x++) {
    for (int y = 0; y < items[0].length; y++) {
      for (int z = 0; z < items[0][0].length; z++)
        for (int w = 0; w < items[0][0][0].length; w++) {
          // If a cube is active and exactly 2 or 3 of its neighbors are also active, the cube remains active.
          // Otherwise, the cube becomes inactive.
          // If a cube is inactive but exactly 3 of its neighbors are active, the cube becomes active.
          // Otherwise, the cube remains inactive.
          if (items[x][y][z][w] != nextState[x][y][z][w]) {
            print('NOT THE SAME.....');
            break;
          }
          var count = countOfCubes(x, y, z, w);
          if (items[x][y][z][w] == true) {
            if (count == 2 || count == 3) {
              nextState[x][y][z][w] = true;
            } else {
              nextState[x][y][z][w] = false;
            }
          } else if (items[x][y][z][w] == false) {
            if (count == 3) {
              nextState[x][y][z][w] = true;
            }
          }
        }
    }
  }
  items = copy(nextState);
}

void buildGrid(width) {
  for (int i = 0; i < width; i++) {
    List<List<List<bool>>> something = [];
    for (int y = 0; y < width; y++) {
      List<List<bool>> pane = [];
      for (int z = 0; z < width; z++) {
        List<bool> line = [];
        for (int w = 0; w < width; w++) {
          line.add(false);
        }
        pane.add(line);
      }
      something.add(pane);
    }
    items.add(something);
  }
}

// 8-15 by 15....

// need to pad ........ around grid by 7....
// in all dimensions....
void readLine(String line) {
  // first line build grid....
  if (lineRead == 0) {
    buildGrid(line.length + 150);
  }
  for (int i = 0; i < line.length; i++) {
    // 0123456789 0 1234567890 depth
    //               01234
    // . means inactive
    // # means active
    if (line[i] == '#') {
      items[75][75][75 + lineRead][75 + i] = true;
    } else {
      items[75][75][75 + lineRead][75 + i] = false;
    }
  }
  lineRead += 1;
}

int answer() {
  // perform rules 6 times and output count
  for (int i = 0; i < 6; i++) {
    print(i + 1);
    applyRules();
  }
  var count = 0;
  for (int x = 0; x < items.length; x++) {
    for (int y = 0; y < items[0].length; y++) {
      for (int z = 0; z < items[0][0].length; z++) {
        for (int w = 0; w < items[0][0][0].length; w++) {
          if (items[x][y][z][w] == true) {
            count += 1;
          }
        }
      }
    }
  }
  return count;
}

// During a cycle, all cubes simultaneously change their state according to the following rules:
//
// If a cube is active and exactly 2 or 3 of its neighbors are also active, the cube remains active. Otherwise, the cube becomes inactive.
// If a cube is inactive but exactly 3 of its neighbors are active, the cube becomes active. Otherwise, the cube remains inactive.

void main() async {
  var file = File('data.txt');
  if (await file.exists()) {
    var contentStream = file.openRead();
    contentStream.transform(Utf8Decoder()).transform(LineSplitter()).listen(
        (String line) => readLine(line),
        onDone: () =>
            print('Answer:${answer()}'), // part2Answer: ${Answer2()}'),
        onError: (e) => print('$e'));
  }
}
