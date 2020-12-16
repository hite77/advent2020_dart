import 'package:flutter_test/flutter_test.dart';
import 'package:passport_app/day13/shuttle_search.dart';

void main() {
  setUp(() {});

  test("sample route", () {
    readLine('939');
    readLine('7,13,x,x,59,x,31,19');
    expect(answer(), 295);
  });

  // test("chinese remainder", () {
  // readLine('17,13,19');
  // readLine('');
  // print(12 % 7);
  // readLine('x,x,6,5,7');
  // print(158 % 5); // 158 is answer.
  // print(158 % 6);
  // print(158 % 7);
  // print('is this 3?:${42 % 5}');
  // expect(1, 1);
  // expect(part2Answer(), 42);
  // });

  // 210612924879242 --> full answer

  test("part 2 samples", () {
    readLine('7,13,x,x,59,x,31,19');
    expect(part2Answer(), 1068781);

    readLine('17,x,13,19');
    expect(part2Answer(), 3417);

    readLine('67,7,59,61');
    expect(part2Answer(), 754018);

    readLine('67,x,7,59,61');
    expect(part2Answer(), 779210);

    readLine('67,7,x,59,61');
    expect(part2Answer(), 1261476);

    readLine('1789,37,47,1889');
    expect(part2Answer(), 1202161486); // 1,202,161,486
  });
}
