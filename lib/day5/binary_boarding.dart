import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:quantity/number.dart';

int convert(seatAssignment) {
  RegExp exp = new RegExp(r"^(.{7})(.{3})$");
  Iterable<Match> matches = exp.allMatches(seatAssignment);
  var firstSevenString = matches.elementAt(0).group(1);
  var row = Binary(firstSevenString
          .replaceAll(new RegExp(r'F'), '0')
          .replaceAll(new RegExp(r'B'), '1'))
      .value;
  var lastThreeString = matches.elementAt(0).group(2);
  var column = Binary(lastThreeString
          .replaceAll(new RegExp(r'L'), '0')
          .replaceAll(new RegExp(r'R'), '1'))
      .value;
  var seatId = row * 8 + column;
  Status.seats.add(seatId);
  return seatId;
}

class Status {
  static int highestSeatId;
  static List<int> seats;
}

void scan(line) {
  var seatValue = convert(line);
  if (seatValue > Status.highestSeatId) {
    Status.highestSeatId = seatValue;
  }
}

int findSeat() {
  Status.seats.sort();
  var lastEntry = 0;
  Status.seats.forEach((element) {
    print(element);
    if (element > 8) {
      if ((element - lastEntry) > 1) {
        print('missing....');
        print(element);
        print('missing....');
      }
    }
    lastEntry = element;
  });
}

void main() async {
  print('binary boarding');
  var file = File('data.txt');
  Status.highestSeatId = 0;
  Status.seats = [];

  if (await file.exists()) {
    var contentStream = file.openRead();
    contentStream.transform(Utf8Decoder()).transform(LineSplitter()).listen(
        (String line) => scan(line),
        onDone: () => print('Answer: ${Status.highestSeatId} ${findSeat()}'),
        onError: (e) => print('$e'));
  }
}
