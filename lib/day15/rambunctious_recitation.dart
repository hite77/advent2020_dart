import 'dart:core';

// read list of starting numbers....
// if first time speaking it, say 0
// if before how many turns apart...
// what is the 2020th number spoken?

int loadAndCalculate(List<int> numbers, {lastElement = 2020}) {
  var turn = 0;
  List<int> spoken = [];
  Map<int, List<int>> turns = new Map();
  numbers.forEach((element) {
    spoken.add(element);
    turns[element] = [turn];
    turn++;
  });
  // need to follow the two rules.... until length == 2020...
  while (spoken.length != lastElement) {
    if (turns[spoken.last].length == 1) {
      // spoken only once....
      spoken.add(0);
      if (turns[0] == null) {
        turns[0] = [turn];
      } else {
        turns[0].add(turn);
      }
    } else {
      var newNumber = turns[spoken.last].last -
          turns[spoken.last][turns[spoken.last].length - 2];
      spoken.add(newNumber);
      if (turns[newNumber] == null) {
        turns[newNumber] = [turn];
      } else {
        turns[newNumber].add(turn);
      }
    }
    turn++;
  }
  return spoken.last;
}

void main() {
  print('Answer: ${loadAndCalculate([7, 14, 0, 17, 11, 1, 2])}');
  print('Answer2: ${loadAndCalculate([
    7,
    14,
    0,
    17,
    11,
    1,
    2
  ], lastElement: 30000000)}');
  // var file = File('data.txt');
  // if (await file.exists()) {
  //   var contentStream = file.openRead();
  //   contentStream.transform(Utf8Decoder()).transform(LineSplitter()).listen(
  //       (String line) => readLine(line),
  //       onDone: () => print('Answer:${answer()} part2Answer: ${Answer2()}'),
  //       onError: (e) => print('$e'));
  // }
}
