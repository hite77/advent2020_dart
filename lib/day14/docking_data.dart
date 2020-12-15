import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:quantity/number.dart';

Map<int, int> memory = new Map();
Map<int, int> memoryPart2 = new Map();
bool part2 = false;

String mask = '';

clear() {
  memory = new Map();
  memoryPart2 = new Map();
}

int applyMaskToInt(value) {
  List<String> build = [""];
  for (int i = 0; i < mask.length; i++) {
    if (mask[i] == '1') {
      build.add(build.last + '1');
    } else if (mask[i] == '0') {
      build.add(build.last + '0');
    } else {
      build.add(build.last + value[i]);
    }
  }
  return Binary(build.last).toInt();
}

void writeMemory(int address, int value) {
  String bitString = value.toRadixString(2);
  memory[address] = applyMaskToInt('0' * (36 - bitString.length) + bitString);
}

String applyMaskForAddress(String address) {
  var build = "";
  for (int i = 0; i < mask.length; i++) {
    print('mask[i]=${mask[i]}');
    if (mask[i] == '1') {
      build += '1';
    } else if (mask[i] == '0') {
      build += address[i];
    } else {
      build += 'X';
    }
  }
  return build;
}

int countX(String addressWithX) {
  var count = 0;
  for (int counter = 0; counter < addressWithX.length; counter++) {
    if (addressWithX[counter] == 'X') {
      count++;
    }
  }
  return count;
}

int addCounterToX(String source, String counter) {
  var positionInCounter = 0;
  var returnString = '';
  for (int i = 0; i < source.length; i++) {
    if (source[i] == 'X') {
      returnString += counter[positionInCounter];
      positionInCounter += 1;
    } else {
      returnString += source[i];
    }
  }
  return Binary(returnString).toInt();
}

List<int> calculateAddresses(String addressWithX) {
  List<int> addresses = [];
  if (!addressWithX.contains('X')) {
    addresses.add(Binary(addressWithX).toInt());
  } else {
    print('Address: $addressWithX');
    var countOfX = countX(addressWithX);
    var counter = -1;
    var counterString;
    do {
      counter += 1;
      var toBinaryString = counter.toRadixString(2);
      counterString = '0' * (countOfX - toBinaryString.length) + toBinaryString;
      print('counter: $counterString');
      addresses.add(addCounterToX(addressWithX, counterString));
    } while (counterString != '1' * countOfX);
  }
  return addresses;
}

writeMaskPart2(int address, int value) {
  List<int> addresses = [];
  // mask tells the addresses to write to, as well as modifying the bitwise address....
  // treat X's as binary counter....
  String bitString = address.toRadixString(2);
  String addressWithX =
      applyMaskForAddress('0' * (36 - bitString.length) + bitString);
  addresses = calculateAddresses(addressWithX);
  addresses.forEach((element) {
    memoryPart2[element] = value;
  });
}

void enablePart2() {
  part2 = true;
}

void readLine(String line) {
  RegExp exp = new RegExp(r"^mask = ([01X]+)$");
  Iterable<Match> matches = exp.allMatches(line);
  if (matches.length > 0) {
    mask = matches.elementAt(0).group(1);
  }
  RegExp expMem = new RegExp(r"^mem\[([0-9]+)\] = ([0-9]+)$");
  Iterable<Match> expMemMatches = expMem.allMatches(line);
  if (expMemMatches.length > 0) {
    writeMemory(int.parse(expMemMatches.elementAt(0).group(1)),
        int.parse(expMemMatches.elementAt(0).group(2)));
    if (part2) {
      writeMaskPart2(int.parse(expMemMatches.elementAt(0).group(1)),
          int.parse(expMemMatches.elementAt(0).group(2)));
    }
  }
}

int answer() {
  var sum = 0;
  memory.keys.forEach((element) {
    sum += memory[element];
  });
  return sum;
}

int Answer2() {
  var sum = 0;
  memoryPart2.keys.forEach((element) {
    sum += memoryPart2[element];
  });
  return sum;
}

void main() async {
  print('shuttle search');
  part2 = true;
  var file = File('data.txt');
  if (await file.exists()) {
    var contentStream = file.openRead();
    contentStream.transform(Utf8Decoder()).transform(LineSplitter()).listen(
        (String line) => readLine(line),
        onDone: () => print('Answer:${answer()} part2Answer: ${Answer2()}'),
        onError: (e) => print('$e'));
  }
}
