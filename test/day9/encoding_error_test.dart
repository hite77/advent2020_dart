import 'package:flutter_test/flutter_test.dart';
import 'package:passport_app/day9/encoding_error.dart';

void main() {
  test("example", () {
    look_for_invalid('1');
    look_for_invalid('2');
    look_for_invalid('3');
    look_for_invalid('4');
    look_for_invalid('5');
    look_for_invalid('6');
    look_for_invalid('7');
    look_for_invalid('8');
    look_for_invalid('9');
    look_for_invalid('10');
    look_for_invalid('11');
    look_for_invalid('12');
    look_for_invalid('13');
    look_for_invalid('14');
    look_for_invalid('15');
    look_for_invalid('16');
    look_for_invalid('17');
    look_for_invalid('18');
    look_for_invalid('19');
    look_for_invalid('20');
    look_for_invalid('21');
    look_for_invalid('22');
    look_for_invalid('23');
    look_for_invalid('24');
    expect(filled, false);
    look_for_invalid('25');
    expect(invalid_value, null);
    expect(filled, true);
    expect(is_invalid(26), false);
    expect(is_invalid(49), false);
    expect(is_invalid(100), true);
    expect(is_invalid(50), true);
    look_for_invalid('45');
    expect(is_invalid(26), false);
    expect(is_invalid(65), false);
    expect(is_invalid(64), false);
    expect(is_invalid(66), false);
  });
}
