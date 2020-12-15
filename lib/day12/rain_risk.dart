import 'dart:convert';
import 'dart:core';
import 'dart:io';

// 0 east
// 90 south
// 180 west
// 270 north

// R 90 --> add 90
// L 90 --> subtract 90.....
// -90 --> should be N which is 270 ==> if negative +360.

int direction = 0; // F goes direction....
int x = 0;
int y = 0;

int waypoint_x = 10;
int waypoint_y = 1;

rotateWaypoint(String angle) {
  var tempX;
  var tempY;
  if (angle == 'L180' || angle == 'R180') {
    tempX = -waypoint_x;
    tempY = -waypoint_y;
  }
  if (angle == 'L90' || angle == 'R270') {
    tempX = -waypoint_y;
    tempY = waypoint_x;
  }
  if (angle == 'R90' || angle == 'L270') {
    //R90.  —> 10 units east and 4 units north. -->  To 4 units east and 10 units south of the shi
    tempX = waypoint_y;
    tempY = -waypoint_x;
  }
  waypoint_x = tempX;
  waypoint_y = tempY;
}

addDirection(String line) {
  // N north distance...
  // S south, E east, W west, L left (90 degree increments)
  // R 90 degree increments
  // F the direction that it is heading....
  var count = int.parse(line.substring(1));
  if (line.startsWith('N')) {
    print('North: $count');
    waypoint_y += count;
  } else if (line.startsWith('S')) {
    print('South: $count');
    waypoint_y -= count;
  } else if (line.startsWith('E')) {
    print('East: $count');
    waypoint_x += count;
  } else if (line.startsWith('W')) {
    print('West: $count');
    waypoint_x -= count;
  } else if (line.startsWith('L')) {
    print('Left: $count');
    rotateWaypoint(line);
  } else if (line.startsWith('R')) {
    print('Right: $count');
    rotateWaypoint(line);
  } else if (line.startsWith('F')) {
    print('Forward: $count');
    x = x + waypoint_x * count;
    y = y + waypoint_y * count;
  }
}

int distance() {
  // need to get absolute sum of east west and north south
  return x.abs() + y.abs();
}

void main() async {
  print('adapter array');
  var file = File('data.txt');
  if (await file.exists()) {
    var contentStream = file.openRead();
    contentStream.transform(Utf8Decoder()).transform(LineSplitter()).listen(
        (String line) => addDirection(line),
        onDone: () =>
            print('Answer:${distance()}'), // part2: ${all_answer_count()}'),
        onError: (e) => print('$e'));
  }
}
