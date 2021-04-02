import 'dart:convert';
import 'dart:core';
import 'dart:io';

//todo:

class Status {
  static int position;
  static int count;
  static bool down_enough;
}

//  Right 1, down 1. 88
//  Right 3, down 1. (This is the slope you already checked.) 145
//  Right 5, down 1. 71
//  Right 7, down 1. 90
//  Right 1, down 2. 41

// 2
// 7
// 3
// 4
// 2

void count_trees(line) {
  var tree = false;
  // print(Status.down_enough);
  if (Status.down_enough) {
    if (line.length <= Status.position) {
      var newstring = line * (Status.position ~/ line.length + 3);
      if (newstring.substring(Status.position, Status.position + 1) == '#') {
        Status.count = Status.count + 1;
        tree = true;
      }
    } else {
      if (line.substring(Status.position, Status.position + 1) == '#') {
        Status.count = Status.count + 1;
        tree = true;
      }
    }
    print(
        'line: $line position: ${Status.position} count: ${Status.count} tree: $tree count: ${Status.down_enough}');
    Status.position = Status.position + 1;
  }

  Status.down_enough = !Status.down_enough;
}

void main() async {
  print('Trees');
  var file = File('sample.txt');
  Status.position = 0;
  Status.count = 0;
  Status.down_enough = true;

  if (await file.exists()) {
    var contentStream = file.openRead();
    contentStream.transform(Utf8Decoder()).transform(LineSplitter()).listen(
        (String line) => count_trees(line),
        onDone: () => print('Answer '),
        onError: (e) => print('$e'));
  }
}
