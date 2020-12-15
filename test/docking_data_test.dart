import 'package:flutter_test/flutter_test.dart';
import 'package:passport_app/day14/docking_data.dart';

void main() {
  setUp(() {
    clear();
  });

  test("sample writing using a mask", () {
    readLine('mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X');
    readLine('mem[8] = 11');
    expect(memory[8], 73);
  });

  test("run the sample and check answer", () {
    readLine('mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X');
    readLine('mem[8] = 11');
    readLine('mem[7] = 101');
    readLine('mem[8] = 0');
    expect(answer(), 165);
  });

  test("part 2", () {
    enablePart2();
    readLine('mask = 000000000000000000000000000000X1001X');
    readLine('mem[42] = 100');
    readLine('mask = 00000000000000000000000000000000X0XX');
    readLine('mem[26] = 1');
    expect(Answer2(), 208);
  });
}
