import 'dart:convert';
import 'dart:core';
import 'dart:io';

var accumulator = 0;
var runningIndex = 0;
List linesRun = [];
List program = [];
List linesToReplace = [];
var repeated = false;

void parse(line) {
  program.add(line);
}

void flop(index) {
  String s;
  print('before: ${program[index]}');
  if (program[index].contains('nop')) {
    s = program[index].replaceAll(new RegExp(r'nop'), 'jmp');
  } else {
    s = program[index].replaceAll(new RegExp(r'jmp'), 'nop');
  }
  program[index] = s;
  print('after: $s');
}

int run_program_with_sub_accumulator() {
  for (int i = 0; i < program.length; i++) {
    String line = program[i];
    if (line.contains('nop') || line.contains('jmp')) {
      print('Adding line $i as nop|jmp');
      linesToReplace.add(i);
    }
  }

  // for(final i in data){
  for (final element in linesToReplace) {
    flop(element);

    print('Running code.... with $element changed');
    print('Accumulator  $accumulator');
    run_accumulator_before_repeat();
    if (repeated == false) {
      break;
    }
    print('Still not found....reset');
    accumulator = 0;
    linesRun = [];
    runningIndex = 0;
    flop(element);
  }
  ;
  return accumulator;
}

int run_accumulator_before_repeat() {
  while (true) {
    String current_instruction = program[runningIndex];
    print('current instruction:$current_instruction}');
    if (linesRun.contains(runningIndex)) {
      repeated = true;
      return accumulator;
    }
    linesRun.add(runningIndex);
    RegExp exp = new RegExp(r"^(nop|acc|jmp) ([+|-][0-9]+)$");
    Iterable<Match> matches = exp.allMatches(current_instruction);
    String operator = matches.elementAt(0).group(1);
    String operand = matches.elementAt(0).group(2);
    if (operator == "nop") {
      runningIndex += 1;
    } else if (operator == "acc") {
      runningIndex += 1;
      accumulator += int.parse(operand);
    } else if (operator == "jmp") {
      runningIndex += int.parse(operand);
    }
    if (runningIndex == program.length) {
      print('made it to end');
      print('accumulator: $accumulator');
      repeated = false;
      return accumulator;
    }
  }
}

void main() async {
  print('handheld halting');
  var file = File('data.txt');
  if (await file.exists()) {
    var contentStream = file.openRead();
    contentStream.transform(Utf8Decoder()).transform(LineSplitter()).listen(
        (String line) => parse(line),
        onDone: () =>
            print('Accumulator:${run_program_with_sub_accumulator()}'),
        onError: (e) => print('$e'));
  }
}
