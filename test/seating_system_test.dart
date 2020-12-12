import 'package:flutter_test/flutter_test.dart';
import 'package:passport_app/day11/seating_system.dart';

@Tags(const ['seating'])
void main() {
  test("addLine builds map", () {
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
  });
}
