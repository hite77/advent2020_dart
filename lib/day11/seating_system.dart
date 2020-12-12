import 'dart:convert';
import 'dart:core';
import 'dart:io';

List<String> map = [];

addLine(line) {
  map.add(line);
}

int answer() {
  return 42;
}

//todo: can I integration test the whole thing?
void main() async {
  print('adapter array');
  var file = File('data.txt');
  if (await file.exists()) {
    var contentStream = file.openRead();
    contentStream.transform(Utf8Decoder()).transform(LineSplitter()).listen(
        (String line) => addLine(line),
        onDone: () =>
            print('Answer:${answer()}'), // part2: ${all_answer_count()}'),
        onError: (e) => print('$e'));
  }
}
