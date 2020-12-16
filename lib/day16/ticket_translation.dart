import 'dart:convert';
import 'dart:core';
import 'dart:io';

// class: 1-3 or 5-7
// two sets of numbers that are valid....

Map<String, List<int>> valid = new Map();
int error_Rate = 0;
List<List<int>> tickets = [];

// 7,1,14....
// and 7,3,47

bool found(int lineElement, List<int> ranges) {
  if ((lineElement >= ranges[0] && lineElement <= ranges[1]) ||
      (lineElement >= ranges[2] && lineElement <= ranges[3])) {
    return true;
  }
  return false;
}

void readLine(String line) {
  if (line.contains('-')) {
    RegExp exp =
        new RegExp(r"^([a-z ]+): ([0-9]+)-([0-9]+) or ([0-9]+)-([0-9]+)$");
    Iterable<Match> matches = exp.allMatches(line);
    List<int> currentRanges = [
      int.parse(matches.elementAt(0).group(2)),
      int.parse(matches.elementAt(0).group(3)),
      int.parse(matches.elementAt(0).group(4)),
      int.parse(matches.elementAt(0).group(5))
    ];
    valid[matches.elementAt(0).group(1)] = currentRanges;
  } else if (line.contains(',')) {
    List<int> currentTicket = [];
    var goodTicket = true;
    line.split(',').forEach((lineElement) {
      // check for two sets... in map
      var foundMatch = false;
      currentTicket.add(int.parse(lineElement));
      valid.keys.forEach((types) {
        if (found(int.parse(lineElement), valid[types])) {
          foundMatch = true;
        }
      });
      if (!foundMatch) {
        error_Rate += int.parse(lineElement);
        goodTicket = false;
      }
    });
    if (goodTicket) {
      tickets.add(currentTicket);
    }
  }
}

String columnNames(int position) {
  var result = '';
  List<int> items = [];
  for (int i = 0; i < tickets.length; i++) {
    items.add(tickets[i][position]);
  }
  valid.keys.forEach((element) {
    // make sure that the numbers are all inside....
    var foundAll = true;
    items.forEach((compare) {
      if (!found(compare, valid[element])) {
        foundAll = false;
      }
    });
    if (foundAll) {
      result += '$element:';
    }
  });
  return result;
}

int answer() {
  print('Good tickets:${tickets[0]}');
  // look at first entry and find keys that it fits in.....
  for (int i = 0; i < tickets[0].length; i++) {
    // I used notepad to whittle them down to what had to be true.
    print('Column names: ${columnNames(i)} for ${tickets[0][i]}');
  }
  return error_Rate;
}

void main() async {
  var file = File('data.txt');
  if (await file.exists()) {
    var contentStream = file.openRead();
    contentStream.transform(Utf8Decoder()).transform(LineSplitter()).listen(
        (String line) => readLine(line),
        onDone: () =>
            print('Answer:${answer()}'), // part2Answer: ${Answer2()}'),
        onError: (e) => print('$e'));
  }
}
