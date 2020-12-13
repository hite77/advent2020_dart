import 'dart:convert';
import 'dart:core';
import 'dart:io';

// first is earliest time stamp....
// id number and how often it leaves
// minutes since referencd time
// 0 they all left...
// id 5 left at 0, 5, 10, 15....
// id 11 left at 0, 11, 22, 33....
// ignore x's.....

int timestamp;
List<int> busIds = [];

readLine(String line) {
  if (timestamp == null) {
    timestamp = int.parse(line);
  } else {
    line.split(',').forEach((element) {
      if (element != 'x') {
        busIds.add(int.parse(element));
      }
    });
  }
  print('timestamp: $timestamp');
  print('busIds: $busIds');
}

int differenceForBus(id) {
  return ((timestamp / id).floor() + 1) * id - timestamp;
}

int answer() {
  var idOfLowestMinutesWait = busIds[0];
  var lowestMinutesWait = differenceForBus(idOfLowestMinutesWait);

  // go through each, multiple id until > timestamp calculate difference
  busIds.forEach((id) {
    if (differenceForBus(id) < lowestMinutesWait) {
      idOfLowestMinutesWait = id;
      lowestMinutesWait = differenceForBus(id);
    }
  });

  return idOfLowestMinutesWait * lowestMinutesWait;
}

//todo: can I integration test the whole thing?
void main() async {
  print('shuttle search');
  var file = File('data.txt');
  if (await file.exists()) {
    var contentStream = file.openRead();
    contentStream.transform(Utf8Decoder()).transform(LineSplitter()).listen(
        (String line) => readLine(line),
        onDone: () =>
            print('Answer:${answer()}'), // part2: ${all_answer_count()}'),
        onError: (e) => print('$e'));
  }
}
