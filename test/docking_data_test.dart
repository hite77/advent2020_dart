import 'package:flutter_test/flutter_test.dart';
import 'package:passport_app/day14/docking_data.dart';

void main() {
  setUp(() {});

  test("sample writing using a mask", () {
    readLine('mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X');
    readLine('mem[8] = 11');
    expect(memory[8], 73);
  });

  // mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
// mem[8] = 11
// mem[7] = 101
// mem[8] = 0

// answer is 165 adding up non zero values

  test("chinese remainder", () {});
}
