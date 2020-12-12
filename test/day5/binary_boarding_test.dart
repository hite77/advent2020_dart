import 'package:flutter_test/flutter_test.dart';
import 'package:passport_app/day5/binary_boarding.dart';

void main() {
  test("converter test", () {
    expect(convert('FBFBBFFRLR'), 357);
    expect(convert('BFFFBBFRRR'), 567);
    expect(convert('FFFBBBFRRR'), 119);
    expect(convert('BBFFBBFRLL'), 820);
  });

  test("scan gets highest value", () {
    Status.highestSeatId = 0;
    expect(Status.highestSeatId, 0);
    scan('FBFBBFFRLR');
    scan('BFFFBBFRRR');
    expect(Status.highestSeatId, 567);
    scan('BBFFBBFRLL');
    expect(Status.highestSeatId, 820);
  });
}
// F means 0
// B means 1
//
// R means 1
// L means 0
////
// FBFBBFF — first 7
//
// RLR — last three
// 101
//
