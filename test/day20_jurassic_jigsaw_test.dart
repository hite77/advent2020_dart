import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
import 'package:passport_app/day20/jurassic_jigsaw.dart';

void main() {
  setUp(() {});

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

  // test('part of string equal', () {
  //   expect(comparePart('abcd', 'abcde'), true);
  //   expect(comparePart('sabcd', 'abcde'), false);
  //   expect(comparePart('foo', 'foobar'), true);
  //   expect(comparePart('first', 'first'), true);
  //   expect(comparePart('firsta', 'first'), false);
  //   List strings = ['one', 'two', 'three'];
  //   strings.remove('one');
  //   print('Strings: $strings');
  // });
}
