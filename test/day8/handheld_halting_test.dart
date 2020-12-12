import 'package:flutter_test/flutter_test.dart';
import 'package:passport_app/day8/handheld_halting.dart';

void main() {
  test("example", () {
    accumulator = 0;
    runningIndex = 0;
    linesRun = [];
    program = [];
    linesToReplace = [];
    repeated = false;
    parse("nop +0");
    parse("acc +1");
    parse("jmp +4");
    parse("acc +3");
    parse("jmp -3");
    parse("acc -99");
    parse("acc +1");
    parse("jmp -4");
    parse("acc +6");
    expect(run_accumulator_before_repeat(), 5);
  });
  test("part2", () {
    accumulator = 0;
    runningIndex = 0;
    linesRun = [];
    program = [];
    linesToReplace = [];
    repeated = false;
    parse("nop +0");
    parse("acc +1");
    parse("jmp +4");
    parse("acc +3");
    parse("jmp -3");
    parse("acc -99");
    parse("acc +1");
    parse("jmp -4");
    parse("acc +6");
    expect(run_program_with_sub_accumulator(), 8);
  });
}
