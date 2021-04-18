import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
import 'package:passport_app/day24/lobby_layout.dart';

void main() {
  setUp(() {
    coords = [];
  });

  test('Read A single string', () {
    readLine('esew');
    expect(answer(), 1);
  });

  test('Read two strings', () {
    readLine('esew');

    readLine('nwwswee');
    expect(answer(), 2);
  });

  test('Cancel each other out', () {
    readLine('esew');
    readLine('esew');
    expect(answer(), 0);
  });

  test('Coordinate of zero zero', () {
    readLine('nenwswse');
    expect(coords.first.x, 0);
    expect(coords.first.y, 0);
  });

  test('Example', () {
    readLine('sesenwnenenewseeswwswswwnenewsewsw');
    readLine('neeenesenwnwwswnenewnwwsewnenwseswesw');
    readLine('seswneswswsenwwnwse');
    readLine('nwnwneseeswswnenewneswwnewseswneseene');
    readLine('swweswneswnenwsewnwneneseenw');
    readLine('eesenwseswswnenwswnwnwsewwnwsene');
    readLine('sewnenenenesenwsewnenwwwse');
    readLine('wenwwweseeeweswwwnwwe');
    readLine('wsweesenenewnwwnwsenewsenwwsesesenwne');
    readLine('neeswseenwwswnwswswnw');
    readLine('nenwswwsewswnenenewsenwsenwnesesenew');
    readLine('enewnwewneswsewnwswenweswnenwsenwsw');
    readLine('sweneswneswneneenwnewenewwneswswnese');
    readLine('swwesenesewenwneswnwwneseswwne');
    readLine('enesenwswwswneneswsenwnewswseenwsese');
    readLine('wnwnesenesenenwwnenwsewesewsesesew');
    readLine('nenewswnwewswnenesenwnesewesw');
    readLine('eneswnwswnwsenenwnwnwwseeswneewsenese');
    readLine('neswnwewnwnwseenwseesewsenwsweewe');
    readLine('wseweeenwnesenwwwswnew');
    expect(answer(), 10);
    expect(answer2(), 2208);
    expect(day(1), 15);
    expect(day(2), 12);
    expect(day(3), 25);
    expect(day(4), 14);
    expect(day(5), 23);
    expect(day(6), 28);
    expect(day(7), 41);
    expect(day(8), 37);
    expect(day(9), 49);
    expect(day(10), 37);
    expect(day(20), 132);
    expect(day(30), 259);
    expect(day(40), 406);
    expect(day(50), 566);
    expect(day(60), 788);
    expect(day(70), 1106);
    expect(day(80), 1373);
    expect(day(90), 1844);
    expect(day(100), 2208);
  });
}
