import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
import 'package:passport_app/day20/jurassic_jigsaw.dart';

void main() {
  setUp(() {
    pictures = new Map();
    board = [];
    pictures[2311] = [
      '..##.#..#.',
      '##..#.....',
      '#...##..#.',
      '####.#...#',
      '##.##.###.',
      '##...#.###',
      '.#.#.#..##',
      '..#....#..',
      '###...#.#.',
      '..###..###'
    ];
    pictures[1951] = [
      '#.##...##.',
      '#.####...#',
      '.....#..##',
      '#...######',
      '.##.#....#',
      '.###.#####',
      '###.##.##.',
      '.###....#.',
      '..#.#..#.#',
      '#...##.#..'
    ];
    pictures[1171] = [
      '####...##.',
      '#..##.#..#',
      '##.#..#.#.',
      '.###.####.',
      '..###.####',
      '.##....##.',
      '.#...####.',
      '#.##.####.',
      '####..#...',
      '.....##...'
    ];
    pictures[1427] = [
      '###.##.#..',
      '.#..#.##..',
      '.#.##.#..#',
      '#.#.#.##.#',
      '....#...##',
      '...##..##.',
      '...#.#####',
      '.#.####.#.',
      '..#..###.#',
      '..##.#..#.'
    ];
    pictures[1489] = [
      '##.#.#....',
      '..##...#..',
      '.##..##...',
      '..#...#...',
      '#####...#.',
      '#..#.#.#.#',
      '...#.#.#..',
      '##.#...##.',
      '..##.##.##',
      '###.##.#..'
    ];
    pictures[2473] = [
      '#....####.',
      '#..#.##...',
      '#.##..#...',
      '######.#.#',
      '.#...#.#.#',
      '.#########',
      '.###.#..#.',
      '########.#',
      '##...##.#.',
      '..###.#.#.'
    ];
    pictures[2971] = [
      '..#.#....#',
      '#...###...',
      '#.#.###...',
      '##.##..#..',
      '.#####..##',
      '.#..####.#',
      '#..#.#..#.',
      '..####.###',
      '..#.#.###.',
      '...#.#.#.#'
    ];
    pictures[2729] = [
      '...#.#.#.#',
      '####.#....',
      '..#.#.....',
      '....#..#.#',
      '.##..##.#.',
      '.#.####...',
      '####.#.#..',
      '##.####...',
      '##..#.##..',
      '#.##...##.'
    ];
    pictures[3079] = [
      '#.#.#####.',
      '.#..######',
      '..#.......',
      '######....',
      '####.#..#.',
      '.#...#.##.',
      '#.#####.##',
      '..#.###...',
      '..#.......',
      '..#.###...'
    ];
  });

  test('compare strings test', () {
    var left2 = '12345';
    expect(left2.split('').reversed.join(), '54321');
    List<String> pic = [
      '1234567890',
      '1234567890',
      '1234567890',
      '1234567890',
      '1234567890',
      '1234567890',
      '1234567890',
      '1234567890',
      '1234567890',
      '1234567890'
    ];

    List<String> rotated = [
      '0000000000',
      '9999999999',
      '8888888888',
      '7777777777',
      '6666666666',
      '5555555555',
      '4444444444',
      '3333333333',
      '2222222222',
      '1111111111'
    ];

    List<String> backwards = [
      '0987654321',
      '0987654321',
      '0987654321',
      '0987654321',
      '0987654321',
      '0987654321',
      '0987654321',
      '0987654321',
      '0987654321',
      '0987654321'
    ];

    pictures[0] = pic;
    expect(grabLeft(0), '1111111111');
    expect(grabRight(0), '0000000000');
    flipHorizontal(0);
    expect(pictures[0], backwards);
    pictures[0] = pic;
    rotateLeft(0);
    expect(pictures[0], rotated);
  });

  //todo: rotate left, and flip horizontal used together
  test('rotated once for 1', () {
    List<String> pic = [
      '1234567890',
      '1234567890',
      '1234567890',
      '1234567890',
      '1234567890',
      '1234567890',
      '1234567890',
      '1234567890',
      '1234567890',
      '1234567890'
    ];
    List<String> rotated = [
      '0000000000',
      '9999999999',
      '8888888888',
      '7777777777',
      '6666666666',
      '5555555555',
      '4444444444',
      '3333333333',
      '2222222222',
      '1111111111'
    ];

    pictures[0] = pic;
    changeState(1, 0);
    expect(pictures[0], rotated);
  });

  test('is flipped after rotate for index 4', () {
    List<String> pic = [
      '1234567890',
      '1234567880',
      '1234567870',
      '1234567860',
      '1234567850',
      '1234567840',
      '1234567830',
      '1234567820',
      '1234567810',
      '1234567800'
    ];
    List<String> rotated_flipped = [
      '0000000000',
      '0123456789',
      '8888888888',
      '7777777777',
      '6666666666',
      '5555555555',
      '4444444444',
      '3333333333',
      '2222222222',
      '1111111111'
    ];

    pictures[0] = pic;
    changeState(4, 0);
    expect(pictures[0], rotated_flipped);
  });

  test('is flipped after rotate for index 8', () {
    List<String> pic = [
      '1234567890',
      '1234567880',
      '1234567870',
      '1234567860',
      '1234567850',
      '1234567840',
      '1234567830',
      '1234567820',
      '1234567810',
      '1234567800'
    ];
    List<String> rotated_flipped = [
      '0000000000',
      '0123456789',
      '8888888888',
      '7777777777',
      '6666666666',
      '5555555555',
      '4444444444',
      '3333333333',
      '2222222222',
      '1111111111'
    ];

    pictures[0] = pic;
    changeState(8, 0);
    expect(pictures[0], rotated_flipped);
  });

  test('Matches a piece from any edge', () {
    List<String> pic = [
      '1234567890',
      '1234567880',
      '1234567870',
      '1234567860',
      '1234567850',
      '1234567840',
      '1234567830',
      '1234567820',
      '1234567810',
      '1234567800'
    ];
    pictures[0] = pic;
    expect(compareEdgeToPiece('1234567890', 0), true);
    expect(compareEdgeToPiece('9234567890', 0), false);
  });

  //todo: look into finding and setting an area of ids.....

  //todo: start rotating each of the pieces
  //todo: compare left and right of two id's....
  //todo: compare top and bottom

  //todo: build the big grid with no borders

  //todo: will need this to rotate left the large array
  //todo: handle smaller and larger matrixes....
  // test('handle any size for rotate', () {
  //   List<String> pic = ['1X2', 'XXX', '4X3'];
  //   pictures[0] = pic;
  //   rotateLeft(0);
  //   expect(pictures[0], ['2X3', 'XXX', '1X4']);
  // });

  test('handle any size for flip horizontal', () {
    List<String> pic = ['1X2', 'XXX', '4X3'];
    pictures[0] = pic;
    flipHorizontal(0);
    expect(pictures[0], ['2X1', 'XXX', '3X4']);
  });

  test('answer2 will build up the board', () {
    answer2();
    List<List<int>> expected = [
      [1951, 2729, 2971],
      [2311, 1427, 1489],
      [3079, 2473, 1171]
    ];
    expect(board, expected);
  });

  //todo: need to rotate and flip horizontal the big array....
}