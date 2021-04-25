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
    expect(coords.first.z, 0);
  });

  test('move ne', () {
    readLine('ne');
    expect(coords.first.x, 1);
    expect(coords.first.y, 0);
    expect(coords.first.z, -1);
  });

  test('move nw', () {
    readLine('nw');
    expect(coords.first.x, 0);
    expect(coords.first.y, 1);
    expect(coords.first.z, -1);
  });

  test('move w', () {
    readLine('w');
    expect(coords.first.x, -1);
    expect(coords.first.y, 1);
    expect(coords.first.z, 0);
  });

  test('move sw', () {
    readLine('sw');
    expect(coords.first.x, -1);
    expect(coords.first.y, 0);
    expect(coords.first.z, 1);
  });

  test('move sw', () {
    readLine('se');
    expect(coords.first.x, 0);
    expect(coords.first.y, -1);
    expect(coords.first.z, 1);
  });

  test('move e', () {
    readLine('e');
    expect(coords.first.x, 1);
    expect(coords.first.y, -1);
    expect(coords.first.z, 0);
  });

  test('calculate extents', () {
    coord first = new coord(-15, 23, 13);
    coord second = new coord(-43, -99, -23);

    extents actual = calculateArea([first, second]);

    expect(actual.minx, -45);
    expect(actual.maxx, -13);
    expect(actual.miny, -101);
    expect(actual.maxy, 25);
    expect(actual.minz, -25);
    expect(actual.maxz, 15);
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
    expect(answer2(), 2208);
  });
}
