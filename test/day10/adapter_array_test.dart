import 'package:flutter_test/flutter_test.dart';
import 'package:passport_app/day10/adapter_array.dart';

void main() {
  test("example1", () {
    registerJolt('16');
    registerJolt('10');
    registerJolt('15');
    registerJolt('5');
    registerJolt('1');
    registerJolt('11');
    registerJolt('7');
    registerJolt('19');
    registerJolt('6');
    registerJolt('12');
    registerJolt('4');
    expect(answer(), 7 * 5);
  });
  test("example2", () {
    registerJolt('28');
    registerJolt('33');
    registerJolt('18');
    registerJolt('42');
    registerJolt('31');
    registerJolt('14');
    registerJolt('46');
    registerJolt('20');
    registerJolt('48');
    registerJolt('47');
    registerJolt('24');
    registerJolt('23');
    registerJolt('49');
    registerJolt('45');
    registerJolt('19');
    registerJolt('38');
    registerJolt('39');
    registerJolt('11');
    registerJolt('1');
    registerJolt('32');
    registerJolt('25');
    registerJolt('35');
    registerJolt('8');
    registerJolt('17');
    registerJolt('7');
    registerJolt('9');
    registerJolt('4');
    registerJolt('2');
    registerJolt('34');
    registerJolt('10');
    registerJolt('3');
    expect(answer(), 22 * 10);
  });

  test("part 2 example1", () {
    registerJolt('16');
    registerJolt('10');
    registerJolt('15');
    registerJolt('5');
    registerJolt('1');
    registerJolt('11');
    registerJolt('7');
    registerJolt('19');
    registerJolt('6');
    registerJolt('12');
    registerJolt('4');
    answer();
    expect(all_answer_count(), 8);
  });

  test("part2 example2", () {
    registerJolt('28');
    registerJolt('33');
    registerJolt('18');
    registerJolt('42');
    registerJolt('31');
    registerJolt('14');
    registerJolt('46');
    registerJolt('20');
    registerJolt('48');
    registerJolt('47');
    registerJolt('24');
    registerJolt('23');
    registerJolt('49');
    registerJolt('45');
    registerJolt('19');
    registerJolt('38');
    registerJolt('39');
    registerJolt('11');
    registerJolt('1');
    registerJolt('32');
    registerJolt('25');
    registerJolt('35');
    registerJolt('8');
    registerJolt('17');
    registerJolt('7');
    registerJolt('9');
    registerJolt('4');
    registerJolt('2');
    registerJolt('34');
    registerJolt('10');
    registerJolt('3');
    answer();
    expect(all_answer_count(), 19208);
  });

  test("parse test", () {
    String value = '111001001';
    int parsed = int.parse(value, radix: 2);
    print(parsed);
  });
}
