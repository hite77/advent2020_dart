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

  test("bumpByOnesTest", () {
    positionEndOfGroups = [5, 8];
    expect(bumpByOnes('111000000'), '111001001');
    positionEndOfGroups = [2, 5];
    expect(bumpByOnes('000000'), '001001');
  });

  test("parse test", () {
    String value = '111001001';
    int parsed = int.parse(value, radix: 2);
    print(parsed);
  });

  test("constructPositionEndOfGroupsTest", () {
    //6, 7, 8 reset count to zero
    //if it jumps more than 1 clear count
    //13, 14, 15
    //position in jolts.
    diffOneAlways = [1, 2, 6, 7, 8, 9, 13, 14, 15, 16];
    // diffThreeAlways = [5,12];
    jolts = [1, 2, 5, 6, 7, 8, 9, 13, 14, 15, 16];
    constructPositionEndOfGroups();
    expect(positionEndOfGroups, [5, 9]);
  });

  test("real one groups", () {
    diffOneAlways = [
      1,
      2,
      6,
      7,
      8,
      9,
      13,
      14,
      18,
      19,
      20,
      21,
      28,
      29,
      33,
      34,
      35,
      39,
      40,
      41,
      42,
      49,
      53,
      54,
      55,
      59,
      60,
      64,
      65,
      66,
      70,
      71,
      75,
      76,
      77,
      78,
      85,
      86,
      87,
      91,
      92,
      93,
      94,
      98,
      99,
      100,
      104,
      105,
      106,
      110,
      111,
      112,
      113,
      117,
      118,
      119,
      120,
      124,
      125,
      129,
      130,
      131,
      132,
      139,
      140,
      141,
      148,
      149,
      150,
      151
    ];
    jolts = [
      1,
      2,
      5,
      6,
      7,
      8,
      9,
      12,
      13,
      14,
      17,
      18,
      19,
      20,
      21,
      24,
      27,
      28,
      29,
      32,
      33,
      34,
      35,
      38,
      39,
      40,
      41,
      42,
      45,
      48,
      49,
      52,
      53,
      54,
      55,
      58,
      59,
      60,
      63,
      64,
      65,
      66,
      69,
      70,
      71,
      74,
      75,
      76,
      77,
      78,
      81,
      84,
      85,
      86,
      87,
      90,
      91,
      92,
      93,
      94,
      97,
      98,
      99,
      100,
      103,
      104,
      105,
      106,
      109,
      110,
      111,
      112,
      113,
      116,
      117,
      118,
      119,
      120,
      123,
      124,
      125,
      128,
      129,
      130,
      131,
      132,
      135,
      138,
      139,
      140,
      141,
      144,
      147,
      148,
      149,
      150,
      151,
      154,
      157
    ];
    constructPositionEndOfGroups();
    expect(positionEndOfGroups, []);
  });

  test("answer really", () {
    print('answer:');
    print(4 *
        8 *
        2 *
        4 *
        8 *
        2 *
        8 *
        8 *
        8 *
        2 *
        2 *
        8 *
        4 *
        8 *
        4 *
        8 *
        2 *
        8 *
        8 *
        2 *
        8 *
        8 *
        8 *
        2 *
        8 *
        2 *
        4 *
        8 *
        2 *
        8 *
        8 *
        2);
  });
}
