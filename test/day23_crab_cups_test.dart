import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
import 'package:passport_app/day23/crab_cups.dart';

void main() {
  // labeled clockwise(your puzzle input)
  // 32415 in circle 3,2,4,1,5 and back to 3
  // before start current cup is first cup....
  // for final there will be 100 moves....

  // pick up three cups that are clockwise of the current cup
  // select a destination cup, one with label equal to current cup label minus one.  It will keep subtracting one till it matches a cup in the circle if it wraps around to lowest it will wrap to highest.
  // place the picked up 3 cups immediately clockwise
  // Select a new current cup which is clockwise of the current cup

  // finally take numbers from 1 clockwise.... and not including 1

  setUp(() {});

  test('output a string', () {
    expect(output([3, 8, 9, 1, 2, 5, 4, 6, 7]), '25467389');
    expect(output([3, 2, 8, 9, 1, 5, 4, 6, 7]), '54673289');
    expect(output([1, 2, 3, 4, 5, 6, 7, 8]), '2345678');
    expect(output([2, 3, 5, 6, 7, 1]), '23567');
    expect(output([5, 6, 1, 8]), '856');
  });

  test('moveThreeCupsHappyPath', () {
    List<int> items = [3, 8, 9, 1, 2, 5, 4, 6, 7];
    List<int> holdThree = [];
    int current_cup = 3;
    moveThreeCups(items, holdThree, current_cup);
    expect(items, [3, 2, 5, 4, 6, 7]);
    expect(holdThree, [8, 9, 1]);
  });

  test('moveThreeCupsLoopAround', () {
    List<int> items = [7, 2, 5, 8, 4, 1, 9, 3, 6];
    List<int> holdThree = [];
    int current_cup = 9;
    moveThreeCups(items, holdThree, current_cup);
    expect(items, [2, 5, 8, 4, 1, 9]);
    expect(holdThree, [3, 6, 7]);
    items = [7, 2, 5, 8, 4, 1, 9, 3, 6];
    holdThree = [];
    current_cup = 3;
    moveThreeCups(items, holdThree, current_cup);
    expect(items, [5, 8, 4, 1, 9, 3]);
    expect(holdThree, [6, 7, 2]);
    items = [7, 2, 5, 8, 4, 1, 9, 3, 6];
    holdThree = [];
    current_cup = 6;
    moveThreeCups(items, holdThree, current_cup);
    expect(items, [8, 4, 1, 9, 3, 6]);
    expect(holdThree, [7, 2, 5]);
  });

  test('updateDestination', () {
    expect(updateDestination([1, 2, 3, 4, 5], 3), 2);
    expect(updateDestination([1, 2, 3, 4, 5], 2), 1);
    expect(updateDestination([1, 2, 3, 4, 5], 1), 5);
    expect(updateDestination([1, 2, 3, 4, 5], 9), 5);
    expect(updateDestination([1, 5, 7, 8], 5), 1);
  });

  test('placeTheCups', () {
    List<int> items = [1, 2, 3, 4, 5];
    List<int> holdThree = [6, 7, 8];
    int current_cup = 5;
    placeTheCups(items, current_cup, holdThree);
    expect(holdThree, []);
    expect(items, [1, 2, 3, 4, 5, 6, 7, 8]);
    holdThree = [9, 11, 10];
    current_cup = 1;
    placeTheCups(items, current_cup, holdThree);
    expect(holdThree, []);
    expect(items, [1, 9, 11, 10, 2, 3, 4, 5, 6, 7, 8]);
  });

  test('clockWiseSelectCup', () {
    expect(clockwiseSelectCup([9, 4, 3, 6, 7], 9), 4);
    expect(clockwiseSelectCup([9, 4, 3, 6, 7], 4), 3);
    expect(clockwiseSelectCup([9, 4, 3, 6, 7], 3), 6);
    expect(clockwiseSelectCup([9, 4, 3, 6, 7], 6), 7);
    expect(clockwiseSelectCup([9, 4, 3, 6, 7], 7), 9);
  });

  test('test move 1', () {
    expect(move('389125467', 1), '54673289');
  });

  test('test move 2', () {
    expect(move('389125467', 2), '32546789');
  });

  test('test move 10', () {
    expect(move('389125467', 10), '92658374');
  });

  test('answer to part 1', () {
    String a = answer('496138527');
    expect(a, 'Answer?');
  });
}
