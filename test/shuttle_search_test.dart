import 'package:flutter_test/flutter_test.dart';
import 'package:passport_app/day13/shuttle_search.dart';

void main() {
  setUp(() {});

  test("sample route", () {
    readLine('939');
    readLine('7,13,x,x,59,x,31,19');
    expect(answer(), 295);
  });
}
