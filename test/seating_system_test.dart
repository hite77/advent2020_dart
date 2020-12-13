import 'package:flutter_test/flutter_test.dart';
import 'package:passport_app/day11/seating_system.dart';

@Tags(const ['seating'])
void main() {
  setUp(() {
    map.clear();
    addLine("L.LL.LL.LL");
    addLine("LLLLLLL.LL");
    addLine("L.L.L..L..");
    addLine("LLLL.LL.LL");
    addLine("L.LL.LL.LL");
    addLine("L.LLLLL.LL");
    addLine("..L.L.....");
    addLine("LLLLLLLLLL");
    addLine("L.LLLLLL.L");
    addLine("L.LLLLL.LL");
  });

  test("addLine builds map", () {
    expect(map[0], 'L.LL.LL.LL');
    expect(map[1], 'LLLLLLL.LL');
    expect(map[2], 'L.L.L..L..');
    expect(map[3], 'LLLL.LL.LL');
    expect(map[4], 'L.LL.LL.LL');
    expect(map[5], 'L.LLLLL.LL');
    expect(map[6], '..L.L.....');
    expect(map[7], 'LLLLLLLLLL');
    expect(map[8], 'L.LLLLLL.L');
    expect(map[9], 'L.LLLLL.LL');
    expect(map.length, 10);
  });

  test("next state is correct", () {
    round();
    // expect(map[0], '#.##.##.##');
    // expect(map[1], '#######.##');
    // expect(map[2], '#.#.#..#..');
    // expect(map[3], '####.##.##');
    // expect(map[4], '#.##.##.##');
    // expect(map[5], '#.#####.##');
    // expect(map[6], '..#.#.....');
    // expect(map[7], '##########');
    // expect(map[8], '#.######.#');
    // expect(map[9], '#.#####.##');
    expect(map[0], '#.##.##.##');
    expect(map[1], '#######.##');
    expect(map[2], '#.#.#..#..');
    expect(map[3], '####.##.##');
    expect(map[4], '#.##.##.##');
    expect(map[5], '#.#####.##');
    expect(map[6], '..#.#.....');
    expect(map[7], '##########');
    expect(map[8], '#.######.#');
    expect(map[9], '#.#####.##');
  });

  test("next state is correct", () {
    round();
    round();
    // expect(map[0], '#.LL.L#.##');
    // expect(map[1], '#LLLLLL.L#');
    // expect(map[2], 'L.L.L..L..');
    // expect(map[3], '#LLL.LL.L#');
    // expect(map[4], '#.LL.LL.LL');
    // expect(map[5], '#.LLLL#.##');
    // expect(map[6], '..L.L.....');
    // expect(map[7], '#LLLLLLLL#');
    // expect(map[8], '#.LLLLLL.L');
    // expect(map[9], '#.#LLLL.##');
    expect(map[0], '#.LL.LL.L#');
    expect(map[1], '#LLLLLL.LL');
    expect(map[2], 'L.L.L..L..');
    expect(map[3], 'LLLL.LL.LL');
    expect(map[4], 'L.LL.LL.LL');
    expect(map[5], 'L.LLLLL.LL');
    expect(map[6], '..L.L.....');
    expect(map[7], 'LLLLLLLLL#');
    expect(map[8], '#.LLLLLL.L');
    expect(map[9], '#.LLLLL.L#');
  });

  test("correct answer", () {
    // repeatedly call round until no changes....
    expect(answer(), 26);
  });
}
