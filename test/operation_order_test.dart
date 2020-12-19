import 'package:flutter_test/flutter_test.dart';
import 'package:passport_app/day18/operation_order.dart';

void main() {
  setUp(() {});

  test('inner paren', () {
    expect(innerParenFactors('(1 + 2 + (42 * 42) + 3)'), '1770');
  });

  test('sample', () {
    expect(add('1 + 2 * 3 + 4 * 5 + 6'), 71);
    expect(add('1770'), 1770);
  });

  test('integration test', () {
    addUp = [];
    readLine('1 + 2 * 3 + 4 * 5 + 6'); // 71
    readLine('1 + (2 * 3) + (4 * (5 + 6))'); //51
    readLine('2 * 3 + (4 * 5)'); //26
    readLine('5 + (8 * 3 + 9 + 3 * 4 * 3)'); //437
    readLine('5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))'); //12240
    readLine('((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2'); //13632
    expect(answer(), 71 + 51 + 26 + 437 + 12240 + 13632);
  });

  test('integration test part 2', () {
    addUp = [];
    readLine('1 + 2 * 3 + 4 * 5 + 6'); // 231
    readLine('1 + (2 * 3) + (4 * (5 + 6))'); //51
    readLine('2 * 3 + (4 * 5)'); //becomes 46
    readLine('5 + (8 * 3 + 9 + 3 * 4 * 3)'); //1445
    readLine('5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))'); // 669060
    readLine('((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2'); // 23340
    expect(Answer2(), 231 + 51 + 46 + 1445 + 669060 + 23340);
  });
}
