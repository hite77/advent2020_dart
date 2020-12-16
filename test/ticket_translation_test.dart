import 'package:flutter_test/flutter_test.dart';
import 'package:passport_app/day16/ticket_translation.dart';

void main() {
  setUp(() {});

  test('sample', () {
    readLine('class: 1-3 or 5-7');
    readLine('row  something: 6-11 or 33-44');
    readLine('seat: 13-40 or 45-50');
    readLine('');
    readLine('your ticket:');
    readLine('7,1,14');
    readLine('');
    readLine('nearby tickets:');
    readLine('7,3,47');
    readLine('40,4,50');
    readLine('55,2,20');
    readLine('38,6,12');
    expect(answer(), 71);
  });
}
