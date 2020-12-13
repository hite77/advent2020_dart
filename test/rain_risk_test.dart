import 'package:flutter_test/flutter_test.dart';
import 'package:passport_app/day12/rain_risk.dart';

void main() {
  setUp(() {});

  test("sample directions", () {
    addDirection('F10');
    addDirection('N3');
    addDirection('F7');
    addDirection('R90');
    addDirection('F11');
    expect(distance(), 286); // 25 was original
  });
}
