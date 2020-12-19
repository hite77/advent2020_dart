import 'dart:convert';
import 'dart:core';
import 'dart:io';

String handleInner(String line, start, end, {partTwo}) {
  // call add on it
  var total = 0;
  var returnValue = '';
  total = add(line.substring(start + 1, end), partTwo: partTwo);
  if (start == 0) {
    returnValue = '$total';
  } else {
    returnValue = line.substring(0, start);
    returnValue += '$total';
  }
  returnValue += line.substring(end + 1);
  return returnValue;
}

String moveOverToInner(var replace, leftOpen, {partTwo}) {
  var rightClose = replace.indexOf(')', leftOpen);
  var nextOpen = replace.indexOf('(', leftOpen + 1);

  if ((nextOpen == -1) || (nextOpen > rightClose)) {
    // handle leftOpen = rightClose
    replace = handleInner(replace, leftOpen, rightClose, partTwo: partTwo);
  } else {
    leftOpen = nextOpen;
    return moveOverToInner(replace, leftOpen, partTwo: partTwo);
  }
  return replace;
}

String innerParenFactors(String line, {partTwo}) {
  if (!line.contains('(')) {
    return line;
  }
  var replace = line;

  while (replace.contains('(')) {
    var leftOpen = replace.indexOf('(');
    replace = moveOverToInner(replace, leftOpen, partTwo: partTwo);
  }
  return replace;
}

int addPartTwo(String no_parens) {
  var remove = no_parens;
  if (!no_parens.contains(' ')) {
    return int.parse(no_parens);
  }
  while (remove.contains(' ')) {
    RegExp exp = new RegExp(r"([0-9]+) ([+]) ([0-9]+)");
    Iterable<Match> matches = exp.allMatches(remove);
    if (matches.length > 0) {
      var sum = int.parse(matches.elementAt(0).group(1));
      sum += int.parse(matches.elementAt(0).group(3));
      var length = matches.elementAt(0).group(0).length;
      var start = remove.indexOf(matches.elementAt(0).group(0));
      var end = start + length;
      var newValue = '';
      if (start == 0) {
        newValue = '$sum';
      } else {
        newValue = remove.substring(0, start);
        newValue += '$sum';
      }
      newValue += remove.substring(end);
      remove = newValue;
    } else {
      RegExp exp = new RegExp(r"([0-9]+) ([*]) ([0-9]+)");
      Iterable<Match> matches = exp.allMatches(remove);
      if (matches.length > 0) {
        var multiply = int.parse(matches.elementAt(0).group(1));
        multiply *= int.parse(matches.elementAt(0).group(3));
        var length = matches.elementAt(0).group(0).length;
        var start = remove.indexOf(matches.elementAt(0).group(0));
        var end = start + length;
        var newValue = '';
        if (start == 0) {
          newValue = '$multiply';
        } else {
          newValue = remove.substring(0, start);
          newValue += '$multiply';
        }
        newValue += remove.substring(end);
        remove = newValue;
      }
    }
  }
  return int.parse(remove);
}

int add(String no_parens, {partTwo}) {
  if (partTwo) {
    return addPartTwo(no_parens);
  }
  var total = 0;
  var remove = no_parens;
  if (!no_parens.contains(' ')) {
    return int.parse(no_parens);
  }
  RegExp exp = new RegExp(r"^([0-9]+) ([+*]) ([0-9]+)");
  Iterable<Match> matches = exp.allMatches(remove);
  if (matches.elementAt(0).group(2) == '+') {
    total += int.parse(matches.elementAt(0).group(1));
    total += int.parse(matches.elementAt(0).group(3));
  } else {
    total += int.parse(matches.elementAt(0).group(1));
    total *= int.parse(matches.elementAt(0).group(3));
  }
  var length = matches.elementAt(0).group(0).length;
  remove = remove.substring(length);

  RegExp anotherExp = new RegExp(r"^ ([+*]) ([0-9]+)");
  matches = anotherExp.allMatches(remove);
  while (matches.length > 0) {
    if (matches.elementAt(0).group(1) == '+') {
      total += int.parse(matches.elementAt(0).group(2));
    } else {
      total *= int.parse(matches.elementAt(0).group(2));
    }
    var length = matches.elementAt(0).group(0).length;
    remove = remove.substring(length);
    matches = anotherExp.allMatches(remove);
  }
  return total;
}

List<String> addUp = [];

void readLine(String line) {
  addUp.add(line);
}

int Answer2() {
  // add parens around +  --> find
  // examples 1 + (2 * 3) --> (1 + (2 * 3))
  // examples 1 + 2 --> (1 + 2)
  // examples (something) + (something) --> ((something) + (something))
  // examples 1 + 2 + 3 * 4

  // or update add....
  var total = 0;
  addUp.forEach((element) {
    total += add(innerParenFactors(element, partTwo: true), partTwo: true);
  });
  return total;
}

int answer() {
  var total = 0;
  addUp.forEach((element) {
    total += add(innerParenFactors(element, partTwo: false), partTwo: false);
  });
  return total;
}

// During a cycle, all cubes simultaneously change their state according to the following rules:
//
// If a cube is active and exactly 2 or 3 of its neighbors are also active, the cube remains active. Otherwise, the cube becomes inactive.
// If a cube is inactive but exactly 3 of its neighbors are active, the cube becomes active. Otherwise, the cube remains inactive.

void main() async {
  var file = File('data.txt');
  if (await file.exists()) {
    var contentStream = file.openRead();
    contentStream.transform(Utf8Decoder()).transform(LineSplitter()).listen(
        (String line) => readLine(line),
        onDone: () => print('Answer:${answer()} part2Answer: ${Answer2()}'),
        onError: (e) => print('$e'));
  }
}
