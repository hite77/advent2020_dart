import 'package:flutter_test/flutter_test.dart';
import 'package:passport_app/day22/crab_combat.dart';

void main() {
  setUp(() {});

  test('readLine Loads board', () {
    readLine('Player 1:');
    readLine('9');
    readLine('2');
    readLine('6');
    readLine('3');
    readLine('1');
    readLine('');
    readLine('Player 2:');
    readLine('5');
    readLine('8');
    readLine('4');
    readLine('7');
    readLine('10');
    expect(player1, [9, 2, 6, 3, 1]);
    expect(player2, [5, 8, 4, 7, 10]);
  });

  test('play updates board', () {
    player1 = [9, 2, 6, 3, 1];
    player2 = [5, 8, 4, 7, 10];

    play(player1, player2);

    expect(player1, [2, 6, 3, 1, 9, 5]);
    expect(player2, [8, 4, 7, 10]);
  });

  test('score works', () {
    player1 = [];
    player2 = [3, 2, 10, 6, 8, 5, 9, 4, 7, 1];

    expect(score(player1, player2), 306);
  });

  test('enoughToRecurse', () {
    expect(enoughToRecurse([1, 2], [1, 3]), true);
    expect(enoughToRecurse([2, 2], [1, 3]), false);
  });

  test('sublist', () {
    expect(sublist([1, 2]), [2]);
    expect(sublist([2, 2, 3]), [2, 3]);
    expect(sublist([4, 1, 2, 3, 4]), [1, 2, 3, 4]);
    List<int> list1 = [4, 1, 2, 3, 4];
    sublist(list1);
    expect(list1, [4, 1, 2, 3, 4]);
  });

  test('followThrough', () {
    player1Recursive = [9, 2, 6, 3, 1];
    player2Recursive = [5, 8, 4, 7, 10];
    answer2();
  });

  // test('playedBefore', () {
  //   player1Hands = [
  //     [1, 2, 3],
  //     [1, 2, 3, 4]
  //   ];
  //   player2Hands = [
  //     [1, 2],
  //     [1, 4]
  //   ];
  //
  //   player1Recursive = [1, 2, 3];
  //   player2Recursive = [1];
  //   expect(playedBefore(player1Recursive, player2Recursive), false);
  //   player2Recursive = [1, 2];
  //   expect(playedBefore(player1Recursive, player2Recursive), true);
  //   player1Recursive = [1, 2, 3, 4];
  //   player2Recursive = [1, 4];
  //   expect(playedBefore(player1Recursive, player2Recursive), true);
  //   player2Recursive = [1, 5];
  //   expect(playedBefore(player1Recursive, player2Recursive), false);
  // });

  //Player 1's deck: 9, 2, 6, 3, 1
  //Player 2's deck: 5, 8, 4, 7, 10

  test('answer2', () {
    // expect(recursivePlay([9, 8, 5, 2], [10, 1, 7]), 2);

    player1Recursive = [9, 2, 6, 3, 1];
    player2Recursive = [5, 8, 4, 7, 10];

    expect(answer2(), 291);
  });

  test('score of 291', () {
    expect(score([7, 5, 6, 2, 4, 1, 10, 8, 9, 3], []), 291);
    expect(score([], [7, 5, 6, 2, 4, 1, 10, 8, 9, 3]), 291);
  });

  test('answer2 real', () {
    player1Recursive = [
      21,
      22,
      33,
      29,
      43,
      35,
      8,
      30,
      50,
      44,
      9,
      42,
      45,
      16,
      12,
      4,
      15,
      27,
      20,
      31,
      25,
      47,
      5,
      24,
      19
    ];
    player2Recursive = [
      3,
      40,
      37,
      14,
      1,
      13,
      49,
      41,
      28,
      48,
      18,
      7,
      23,
      38,
      32,
      34,
      46,
      39,
      17,
      2,
      11,
      6,
      10,
      36,
      26
    ];

    expect(answer2(), 32751);
  });
}
