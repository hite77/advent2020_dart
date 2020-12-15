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
List<int> part2Ids = [];

readLine(String line) {
  if (!line.contains('x') && !line.contains(',')) {
    timestamp = int.parse(line);
  } else if (line.contains(',')) {
    busIds = [];
    part2Ids = [];
    line.split(',').forEach((element) {
      if (element != 'x') {
        busIds.add(int.parse(element));
        part2Ids.add(int.parse(element));
      } else {
        part2Ids.add(-1);
      }
    });
  }
  print('timestamp: $timestamp');
  print('busIds: $busIds');
  print('part2Ids: $part2Ids');
}

int differenceForBus(id) {
  return ((timestamp / id).floor() + 1) * id - timestamp;
}

int part2Answer() {
  var multiplier;
  // find biggest number column, and offset.... start at that number...
  var biggest = 0;
  var offset_biggest = 0;
  for (var i = 0; i < part2Ids.length; i++) {
    if (part2Ids[i] > offset_biggest) {
      biggest = part2Ids[i];
      offset_biggest = i;
    }
  }

  //timestamp is the start.... if it is data value, set to huge start
  if (timestamp == 1000510) {
    timestamp = 1895420000000000;
    multiplier = (timestamp / biggest).floor();
    timestamp = multiplier * biggest - offset_biggest;
    print('Start timestamp: $timestamp');
  } else {
    timestamp = biggest - offset_biggest;
    multiplier = 1;
  }
  print('timestamp: $timestamp : multiplier: $multiplier');

  var found = false;
  while (!found) {
    for (var i = 0; i < part2Ids.length; i++) {
      if (part2Ids[i] != -1) {
        var trueValue = timestamp / part2Ids[i];
        var arrivalTime;
        if (trueValue == (timestamp / part2Ids[i]).floor()) {
          arrivalTime = trueValue * part2Ids[i];
        } else {
          arrivalTime = (trueValue.floor() + 1) * part2Ids[i];
        }
        if ((arrivalTime - timestamp) == i) {
          found = true;
        } else {
          multiplier += 1;
          timestamp = multiplier * biggest - offset_biggest;
          print('i: $i multiplier: $multiplier :trying timestamp: $timestamp ');
          found = false;
          break;
        }
      }
    }
  }

  return timestamp;
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

void main() async {
  print('shuttle search');
  var file = File('data.txt');
  if (await file.exists()) {
    var contentStream = file.openRead();
    contentStream.transform(Utf8Decoder()).transform(LineSplitter()).listen(
        (String line) => readLine(line),
        onDone: () => print('Answer:${answer()} part2Answer: ${part2Answer()}'),
        onError: (e) => print('$e'));
  }
}
