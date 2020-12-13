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

addDirection(String line) {
  // N north distance...
  // S south, E east, W west, L left (90 degree increments)
  // R 90 degree increments
  // F the direction that it is heading....
  var count = int.parse(line.substring(1));
  if (line.startsWith('N')) {
    print('North: $count');
    y = y + count;
  } else if (line.startsWith('S')) {
    print('South: $count');
    y = y - count;
  } else if (line.startsWith('E')) {
    print('East: $count');
    x = x + count;
  } else if (line.startsWith('W')) {
    print('West: $count');
    x = x - count;
  } else if (line.startsWith('L')) {
    print('Left: $count');
    direction = direction - count;
    if (direction < 0) {
      direction = direction + 360;
    }
    print('Direction: $direction');
  } else if (line.startsWith('R')) {
    print('Right: $count');
    direction = direction + count;
    if (direction >= 360) {
      direction = direction - 360;
    }
    print('Direction: $direction');
  } else if (line.startsWith('F')) {
    print('Forward: $count : direction: $direction');
    // 0 east
    // 90 south
    // 180 west
    // 270 north
    var send = 'directions';
    if (direction == 0) {
      send = 'E$count';
    } else if (direction == 90) {
      send = 'S$count';
    } else if (direction == 180) {
      send = 'W$count';
    } else if (direction == 270) {
      send = 'N$count';
    }
    print(send);
    addDirection(send);
  }
}

int distance() {
  // need to get absolute sum of east west and north south
  return x.abs() + y.abs();
}

//todo: can I integration test the whole thing?
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
