import 'dart:convert';
import 'dart:core';
import 'dart:io';

// todo: tests?

void call_again(l, x) {
  l.forEach((y) => call_one_more(l, x, y));
}

void call_one_more(l, x, y) {
  l.forEach((z) => process(x, y, z));
}

void process(x, y, z) {
  var newx = int.parse(x);
  var newy = int.parse(y);
  var newz = int.parse(z);
  if (newx + newy + newz == 2020) {
    print(newx);
    print(newy);
    print(newz);
    print(newx * newy * newz);
    print('^^^^^^^');
  }
}

void main() async {
  print('Hello, World!');
  var file = File('data.txt');
  List l = [];

  if (await file.exists()) {
    var contentStream = file.openRead();
    contentStream.transform(Utf8Decoder()).transform(LineSplitter()).listen(
        (String line) => l.add(line),
        onDone: () => l.forEach((x) => call_again(l, x)),
        onError: (e) => print('$e'));
  }
}
