import 'dart:convert';
import 'dart:core';
import 'dart:io';

//todo: tests?

part_one(letter, string, low_count, high_count, count) {
  var count_of_letter = letter.allMatches(string).length;
  if ((count_of_letter >= low_count) && (count_of_letter <= high_count)) {
    count = count + 1;
    return count;
  }
  return count;
}

part_two(letter, string, low_count, high_count, count) {
  if ((string.substring(low_count - 1, low_count) == letter) ||
      (string.substring(high_count - 1, high_count) == letter)) {
    if (string.substring(low_count - 1, low_count) !=
        string.substring(high_count - 1, high_count)) {
      count = count + 1;
      return count;
    }
  }
  return count;
}

int count_valid(line, count) {
  RegExp exp = new RegExp(r"([0-9]+)-([0-9]+) ([a-z]): ([a-z]+)");
//use func firstMatch to get first matching String
  Iterable<Match> matches = exp.allMatches(line);

  if (matches == null) {
    print("No match");
  } else {
    // group(0) => full matched text
    // if regex had groups. groups can be extracted
    // using group(1), group(2)...
    var low_count = int.parse(matches.elementAt(0).group(1));
    var high_count = int.parse(matches.elementAt(0).group(2));
    var letter = matches.elementAt(0).group(3);
    var string = matches.elementAt(0).group(4);

    return part_two(letter, string, low_count, high_count, count);
  }
}

void main() async {
  print('Passwords');
  var file = File('data.txt');
  List l = [];
  var count = 0;

  if (await file.exists()) {
    var contentStream = file.openRead();
    contentStream.transform(Utf8Decoder()).transform(LineSplitter()).listen(
        (String line) => count = count_valid(line, count),
        onDone: () => print('Answer count: $count'),
        onError: (e) => print('$e'));
  }
}
