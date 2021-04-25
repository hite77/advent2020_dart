import 'dart:convert';
import 'dart:core';
import 'dart:io';

class extents {
  int minx, maxx, miny, maxy, minz, maxz;
}

class coord {
  int x;
  int y;
  int z;

  coord(int x, int y, int z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }

  bool operator ==(o) => o.x == x && o.y == y && o.z == z;
}

List<coord> coords = [];

//e, se, sw, w, nw, and ne
readLine(String line) {
  coord current = new coord(0, 0, 0);
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
      current.x = current.x + 1;
      current.y = current.y - 1;
    } else if (direction == 'se') {
      current.z = current.z + 1;
      current.y = current.y - 1;
    } else if (direction == 'sw') {
      current.x = current.x - 1;
      current.z = current.z + 1;
    } else if (direction == 'w') {
      current.x = current.x - 1;
      current.y = current.y + 1;
    } else if (direction == 'nw') {
      current.z = current.z - 1;
      current.y = current.y + 1;
    } else if (direction == 'ne') {
      current.x = current.x + 1;
      current.z = current.z - 1;
    }
  }
  if (coords.contains(current)) {
    coords.remove(current);
  } else {
    coords.add(current);
  }
}

int answer() {
  return coords.length;
}

int countAround(coord position, List<coord> black) {
  // return count of black (in list) around position.
  int count = 0;
  if (black.contains(new coord(position.x, position.y + 1, position.z - 1))) {
    count += 1;
  }
  if (black.contains(new coord(position.x - 1, position.y + 1, position.z))) {
    count += 1;
  }
  if (black.contains(new coord(position.x - 1, position.y, position.z + 1))) {
    count += 1;
  }
  if (black.contains(new coord(position.x, position.y - 1, position.z + 1))) {
    count += 1;
  }
  if (black.contains(new coord(position.x + 1, position.y - 1, position.z))) {
    count += 1;
  }
  if (black.contains(new coord(position.x + 1, position.y, position.z - 1))) {
    count += 1;
  }
  return count;
}

extents calculateArea(List<coord> before) {
  int minx = (before.first).x;
  int maxx = (before.first).x;
  int miny = (before.first).y;
  int maxy = (before.first).y;
  int minz = (before.first).z;
  int maxz = (before.first).z;

  before.forEach((coord element) {
    if (element.x < minx) {
      minx = element.x;
    }
    if (element.x > maxx) {
      maxx = element.x;
    }
    if (element.y < miny) {
      miny = element.y;
    }
    if (element.y > maxy) {
      maxy = element.y;
    }
    if (element.z < minz) {
      minz = element.z;
    }
    if (element.z > maxz) {
      maxz = element.z;
    }
  });

  minx -= 2;
  maxx += 2;
  miny -= 2;
  maxy += 2;
  minz -= 2;
  maxz += 2;

  extents extent = new extents();
  extent.minx = minx;
  extent.maxx = maxx;
  extent.miny = miny;
  extent.maxy = maxy;
  extent.minz = minz;
  extent.maxz = maxz;
  return extent;
}

int day(int d) {
  List<coord> before = [];
  List<coord> after = [];
  int count = 0;

  coords.forEach((element) {
    before.add(element);
  });

  for (var dayCounter = 0; dayCounter < d; dayCounter++) {
    extents border = calculateArea(before);

    for (var x = border.minx; x <= border.maxx; x++) {
      for (var y = border.miny; y <= border.maxy; y++) {
        for (var z = border.minz; z <= border.maxz; z++) {
          coord currentPosition = new coord(x, y, z);
          var currentCount = countAround(currentPosition, before);
          // determine black or white...
          if (before.contains(currentPosition)) {
            // black
            if ((currentCount == 1) || (currentCount == 2)) {
              after.add(currentPosition);
            }
          } else {
            // white
            if (currentCount == 2) {
              // becomes black, if white it will remain white with nothing required
              after.add(currentPosition);
            }
          }
        }
      }
    }

    // flip after to before, and get count
    // and keep clicking days
    before = [];
    count = 0;
    after.forEach((element) {
      before.add(element);
      count += 1;
    });
    after = [];
  }
  return count;
}

int answer2() {
  // 4205 is wrong answer
  return day(100);
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
