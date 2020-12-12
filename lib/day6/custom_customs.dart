import 'dart:convert';
import 'dart:core';
import 'dart:io';

class Status {
  static int countOfQuestions;
  static int countOfAllYes;
  static String questions;
  static List<bool> register;
  static bool firstLine;
}

void countUp() {
  Status.register.forEach((element) {
    if (element) {
      Status.countOfAllYes += 1;
    }
  });
  int c = "a".codeUnitAt(0);
  int end = "z".codeUnitAt(0);
  while (c <= end) {
    if (Status.questions.contains(new String.fromCharCode(c))) {
      Status.countOfQuestions += 1;
    }
    c++;
  }
  Status.questions = '';
}

void sum(line) {
  if (line == '') {
    print(Status.questions);
    countUp();
    Status.questions = '';
    Status.firstLine = true;
  } else {
    if (Status.firstLine) {
      Status.firstLine = false;
      Status.register = new List.filled(26, false);
      int c = "a".codeUnitAt(0);
      int diff = c;
      int end = "z".codeUnitAt(0);
      while (c <= end) {
        if (line.contains(new String.fromCharCode(c))) {
          Status.register[c - diff] = true;
        }
        c++;
      }
    }
    print('Line:$line');
    int c = "a".codeUnitAt(0);
    int diff = c;
    int end = "z".codeUnitAt(0);
    while (c <= end) {
      if ((Status.register[c - diff]) &&
          (line.contains(new String.fromCharCode(c)))) {
        Status.register[c - diff] = true;
      } else {
        Status.register[c - diff] = false;
      }
      c++;
    }
    Status.questions += line;
  }
}

int lastAdd() {
  countUp();
  print(
      'Answer: ${Status.countOfQuestions}, AllYes => ${Status.countOfAllYes}');
}

void main() async {
  print('custom customs');
  var file = File('data.txt');
  Status.countOfQuestions = 0;
  Status.questions = '';
  Status.firstLine = true;
  Status.countOfAllYes = 0;

  if (await file.exists()) {
    var contentStream = file.openRead();
    contentStream.transform(Utf8Decoder()).transform(LineSplitter()).listen(
        (String line) => sum(line),
        onDone: () => lastAdd(),
        onError: (e) => print('$e'));
  }
}
