import 'dart:convert';
import 'dart:core';
import 'dart:io';

//36 bit mask.... can be set
//Memory as a map...
//decimal values to binary then apply mask
//push as decimal...
//int keys = int....

Map<int, int> memory = new Map();

String mask = '';

List<bool> readLine(String line) {
  if (line.startsWith('mask =')) {
    mask = line.substring(startIndex)
  }
}

int answer() {}

void main() async {
  print('shuttle search');
  var file = File('data.txt');
  if (await file.exists()) {
    var contentStream = file.openRead();
    contentStream.transform(Utf8Decoder()).transform(LineSplitter()).listen(
        (String line) => readLine(line),
        onDone: () =>
            print('Answer:${answer()} '), //part2Answer: ${part2Answer()}'),
        onError: (e) => print('$e'));
  }
}
