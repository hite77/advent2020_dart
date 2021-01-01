import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
import 'package:passport_app/day19/monster_messages.dart';

void main() {
  setUp(() {
    rules = new Map();
  });

  test('compare strings test', () {
    readLine('0: 1 2');
    readLine('1: "a"');
    readLine('2: 1 3 | 3 1');
    readLine('3: "b"');
    readLine('');
    readLine('aaaba');
    readLine('foo');
    expect(receivedMessages, ['aaaba', 'foo']);
    expect(rules[0], '1 2');
    expect(rules[1], 'a');
    expect(rules[2], "1 3 | 3 1");
    expect(rules[3], 'b');
    expect(getStrings(), ['aab', 'aba']);
  });

  test('pass through works', () {
    readLine('0: 1');
    readLine('1: "j');
    expect(getStrings(), ['j']);
  });

  test('another example', () {
    readLine('0: 4 1 5'); // 1 => aa
    //   => bb
    readLine('1: 2 3 | 3 2');
    readLine('2: 4 4 | 5 5');
    readLine('3: 4 5 | 5 4');
    readLine('4: "a"');
    readLine('5: "b"');
    readLine('ababbb');
    readLine('bababa');
    readLine('abbbab');
    readLine('aaabbb');
    readLine('aaaabbb');
    print(getStrings());
    expect(getStrings(), [
      'aaaabb',
      'aaabab',
      'abbabb',
      'abbbab',
      'aabaab',
      'aabbbb',
      'abaaab',
      'ababbb'
    ]);
    expect(answer(), 2);
  });

  test('test or', () {
    readLine('1: "a"');
    readLine('0: 1 3 | 3 1');
    readLine('3: "b"');
    expect(getStrings(), ['ab', 'ba']);
  });

  test('example part 2', () {
    // readLine('0: 1 2');
    // readLine('1: "a"');
    // readLine('2: 1 3 | 3 1');
    // readLine('3: "b"');

    readLine('42: 9 14 | 10 1');
    readLine('9: 14 27 | 1 26');
    readLine('10: 23 14 | 28 1');
    readLine('1: "a"');
    readLine('11: 42 31');
    readLine('5: 1 14 | 15 1');
    readLine('19: 14 1 | 14 14');
    readLine('12: 24 14 | 19 1');
    readLine('16: 15 1 | 14 14');
    readLine('31: 14 17 | 1 13');
    readLine('6: 14 14 | 1 14');
    readLine('2: 1 24 | 14 4');
    readLine('0: 8 11');
    readLine('13: 14 3 | 1 12');
    readLine('15: 1 | 14');
    readLine('17: 14 2 | 1 7');
    readLine('23: 25 1 | 22 14');
    readLine('28: 16 1');
    readLine('4: 1 1');
    readLine('20: 14 14 | 1 15');
    readLine('3: 5 14 | 16 1');
    readLine('27: 1 6 | 14 18');
    readLine('14: "b"');
    readLine('21: 14 1 | 1 14');
    readLine('25: 1 1 | 1 14');
    readLine('22: 14 14');
    readLine('8: 42');
    readLine('26: 14 22 | 1 20');
    readLine('18: 15 15');
    readLine('7: 14 5 | 1 21');
    readLine('24: 14 1');

    receivedMessages.add('abbbbbabbbaaaababbaabbbbabababbbabbbbbbabaaaa');
    receivedMessages.add('bbabbbbaabaabba');
    receivedMessages.add('babbbbaabbbbbabbbbbbaabaaabaaa');
    receivedMessages.add('aaabbbbbbaaaabaababaabababbabaaabbababababaaa');
    receivedMessages.add('bbbbbbbaaaabbbbaaabbabaaa');
    receivedMessages.add('bbbababbbbaaaaaaaabbababaaababaabab');
    receivedMessages.add('ababaaaaaabaaab');
    receivedMessages.add('ababaaaaabbbaba');
    receivedMessages.add('baabbaaaabbaaaababbaababb');
    receivedMessages.add('abbbbabbbbaaaababbbbbbaaaababb');
    receivedMessages.add('aaaaabbaabaaaaababaa');
    receivedMessages.add('aaaabbaaaabbaaa');
    receivedMessages.add('aaaabbaabbaaaaaaabbbabbbaaabbaabaaa');
    receivedMessages.add('babaaabbbaaabaababbaabababaaab');
    receivedMessages.add('aabbbbbaabbbaaaaaabbbbbababaaaaabbaaabba');

    List items42 = build('42');
    List items31 = build('31');
    List matchedMessages = [];

    //13
    List combinations = [
      '42 42 31',
      '42 42 42 31',
      '42 42 42 42 31',
      '42 42 42 42 42 31',
      '42 42 42 42 42 42 31',
      '42 42 42 42 42 42 42 31',
      '42 42 42 42 42 42 42 42 31',
      '42 42 42 42 42 42 42 42 42 31', // 10
      '42 42 42 42 42 42 42 42 42 42 31',
      '42 42 42 42 42 42 42 42 42 42 42 31',
      '42 42 42 42 42 42 42 42 42 42 42 42 31', //13
      '42 42 42 31 31', // right 11 1 5 sets
      '42 42 42 42 31 31', // right 11 1 6 sets
      '42 42 42 42 42 31 31', // right 11 1 7 sets
      '42 42 42 42 42 42 31 31', // right 11 1 8 sets
      '42 42 42 42 42 42 42 31 31', // right 11 1 9 sets
      '42 42 42 42 42 42 42 42 31 31', // right 11 1 10 sets
      '42 42 42 42 42 42 42 42 42 31 31', // right 11 1 11 sets
      '42 42 42 42 42 42 42 42 42 42 31 31', // right 11 1 12 sets
      '42 42 42 42 42 42 42 42 42 42 42 31 31', // right 11 1 13 sets

      '42 42 42 42 31 31 31', // 11 twice 7 sets
      '42 42 42 42 42 31 31 31', // 11 twice 8 sets
      '42 42 42 42 42 42 31 31 31', // 11 twice 9 sets
      '42 42 42 42 42 42 42 31 31 31', // 11 twice 10 sets
      '42 42 42 42 42 42 42 42 31 31 31', // 11 twice 11 sets
      '42 42 42 42 42 42 42 42 42 31 31 31', // 11 twice 12 sets
      '42 42 42 42 42 42 42 42 42 42 31 31 31', // 11 twice 13 sets

      '42 42 42 42 42 31 31 31 31', // 11 three 9 sets
      '42 42 42 42 42 42 31 31 31 31', // 11 three 10 sets
      '42 42 42 42 42 42 42 31 31 31 31', // 11 three 11 sets
      '42 42 42 42 42 42 42 42 31 31 31 31', // 11 three 12 sets
      '42 42 42 42 42 42 42 42 42 31 31 31 31', // 11 three 13 sets

      '42 42 42 42 42 42 31 31 31 31 31', // 11 four 11 sets
      '42 42 42 42 42 42 42 31 31 31 31 31', // 11 four 12 sets
      '42 42 42 42 42 42 42 42 31 31 31 31 31', // 11 four 13 sets
      '42 42 42 42 42 42 42 31 31 31 31 31 31', // 11 five 13 sets
    ];

    combinations.forEach((element) {
      andTogether(element, items42, items31, receivedMessages, matchedMessages);
    });
    // / 8: 42 | 42 8 —> 42 by itself and then 42 and 42, and also 42 and 42 and 42…. : count 24 combined… 72
// 11: 42 31 | 42 11 31.  —> 42 (42 31) 31 —> 42 ( 42 (42 31) 31 31. Count 48
    // left left...

    var length42 = items42.first.length;
    var length31 = items31.first.length;

    items42.forEach((element) {
      if (element.length < length42) {
        length42 = element.length;
      }
    });
    items31.forEach((element) {
      if (element.length < length31) {
        length31 = element.length;
      }
    });

    print('length 42: $length42');
    print('length 31: $length31');
    print('42: $items42');
    print('31: $items31');

    print('received messages longest: ${receivedMessages.first.length}');
    print('matched: $matchedMessages');
    expect(matchedMessages.length, 12);
  });

  test('addWorks', () {
    receivedMessages.add('abbaabbbaaaaaabaababbabbababaaba');
    receivedMessages.add('babbbbbbbbababaaaaaababbbabababaabbaaaaabbabaaab');
    receivedMessages.add('aaaaabaaabbbaabbaaababaa');
    receivedMessages.add('babababbaaababbbbababaaaaabbaababbbabaaa');
    receivedMessages.add('bbaaaaaababbaaabaabaabbb');
    receivedMessages.add('aabbbaaaabbaaabbbabbbaaa');
    receivedMessages.add('aabbbaabaababbabbbbbbaba');
    receivedMessages.add('bbbaaabbaaaaabbabbabbaab');
    receivedMessages.add('abbbbbaababbababbbbbaabaabbababaabbaabaa');
    receivedMessages.add('aabbabbabbabaabababbbabaabababbb');
    receivedMessages.add('bbaaabbabbaaabbabaabbaaaaaaaaaabaabaaabbbaabaabb');
    receivedMessages.add('bbaabbabbabbabaaabbbbabb');
    receivedMessages.add('aaaabbbbaaaabaabbababaabbbabaaabaabbabab');
    receivedMessages.add('abbbaabbbbabbaaabaaabbab');
    receivedMessages.add('bbbabbbaaabbbababbaaabbb');
    receivedMessages.add('abbababbaaabababbbbbbbab');
    receivedMessages.add('aabbaaaabbaaaaabaaababbbbbaabaaa');
    receivedMessages.add('abaaabaaaabbababbabbabbbabbaabbabbaabbbb');
    receivedMessages.add('abbbbbaaaaaabbaabbbbbbab');
    receivedMessages.add('babaaaaabbbabbaaabbabaaa');
    receivedMessages.add('aaabaaaaabaababaaaabbaab');
    receivedMessages.add(
        'babbababaaaaababaabbaaabbbbbaaababbbaaaaababaaabbabbbbabaabbabababbaabba');
    receivedMessages.add(
        'bbbbbbbaababbabbaaaaabaabaaaaabbababbbbbbabaabbaabababaaaabbabba');
    receivedMessages.add('bbbaabbbaaaabababababbbb');
    receivedMessages.add('babbbbbaabbbaababababbab');
    receivedMessages.add('bbabaaaaabbbabaaabbbbabb');
    receivedMessages.add('bbbaabaabaabbaaaaaababbbaababbbaaabababbbaaabbba');
    receivedMessages.add('abbabababbabaaaaabbbaaab');
    receivedMessages.add('bbbaaabaaaaaaabbabababbaaaabbbaabaaaaabaaabaaaaa');
    receivedMessages.add(
        'aabbabbabbaababbbbaababbbbabaaaaaabbabbabbaaabbbbaaabaabbabbbbbb');
    receivedMessages
        .add('bbababbaababbabababbaaababaabaabbaaabbabababaaabbabbbbba');
    receivedMessages
        .add('baaababbbbabbbbababbaaababbaaabbbbbaaaaaabaabbabbababbba');
    receivedMessages.add('aabbaaaabaaaabbabbababbb');
    receivedMessages.add('aaaabbaaaabaabbaaabaabbb');
    receivedMessages.add(
        'bbbbbbbbababbabaaaaaaaabaabbbabbbabbabbaaaaaabbaababbaabababbbab');
    receivedMessages.add('aaaaabaaaabababaaabbbbbaabbbbbbbbabbaaaa');
    receivedMessages.add('aabbbbbaaaabbbbbaabbaabb');
    receivedMessages.add('abbbbbbbaaabbbbbbaababab');
    receivedMessages.add('aaababbababbaaababbabbaa');
    receivedMessages.add('babbbabbbaaaaabbbabababa');
    receivedMessages.add('bbbaabbbbbbaaaaaaaaaaababbabaaaabbabbaababaaaaba');
    receivedMessages.add('bbaaaaaabbababaabbbaabaabaaaabaaabaaabbb');
    receivedMessages.add('babbbabaaaabbbbbbabbaabb');
    receivedMessages.add('aabaaabbaababababbabbaaaaabababb');
    receivedMessages.add('babaaabbabaaaaaaabbaababbabababa');
    receivedMessages.add(
        'bbababaabaaabaaababaababbaaaabbbaaaabaabaabbbaabbbaabbabbbbabbaaabbbbbbbaaaaabbabbbbabaaabbaaabb');
    receivedMessages.add('aaabaaaaaabbbaababbbbaba');
    receivedMessages.add('bbbbaaaababaaabbbbabbabb');
    receivedMessages.add('bbbabbbaaabbbaaabbabbaaabbaabbba');
    receivedMessages.add('baaaabbaabaaababbbbabaaa');
    receivedMessages.add('aabbbababbbbbabbaaaaabbbaaabbababaaababbabbbabbb');
    receivedMessages.add('abaaabaaabaaabaaaaabaaabaababbaa');
    receivedMessages
        .add('bbaaababbbbbbbbbaaaaaaaabbbabaabbaaaaabbbbaaaaaabbaaaaaa');
    receivedMessages.add('bbbaaabbabbbbaabaabbbbbabaababba');
    receivedMessages.add('babaaaaababbaaabababaabb');
    receivedMessages.add('aaaaaaabaaaabaabbabaabababababbababababa');
    receivedMessages.add('aabbaaabbaabaaaaaababbaa');
    receivedMessages.add('abbbaabaaabbbaababbaaabbbbaaabbbaabaaaaa');
    receivedMessages.add('bbbbbbbbbaababbbbbababaaababbbaa');
    receivedMessages.add('babaaaabbbbaabbabbbbbaaaaaaaaaaaabbbbbabaabbbbbb');
    receivedMessages.add('abaababababaaabbaaabaaba');
    receivedMessages.add('babaabbbaabbbabaaaaabbab');
    receivedMessages.add(
        'ababaabbaabbbaaaabbaabbaaaababbbbabaabaabbaabbbabbabbbbbaabbabaa');
    receivedMessages.add('aabaabbaaaabaaaabaabbbaa');
    receivedMessages.add('baabbbbbbaababbabbabbabaabbbabbb');
    receivedMessages.add('abaaaaaababbbbbaababababbbbbbbaaaabbbbabbaabbbbb');
    receivedMessages
        .add('aabbbabaaaaabbaabaaaababbbbbaabbaaabbabbbabbbaaaaababbbb');
    receivedMessages.add('babbabaaaaaaabbababbaabb');
    receivedMessages.add('ababbabaaabbbbbabbaaaaba');
    receivedMessages.add('baaabbbbbbbabbbababaabbbbbaabbbb');
    receivedMessages
        .add('aaaabaaaaabbbbbbbbbbaababababbaabbbbbbabaabaabaaaaaabbbb');
    receivedMessages.add('abbababaaabbbbbabbabbbabbbbabbba');
    receivedMessages.add('abbababaabaababaabababaa');
    receivedMessages.add(
        'bbaaaabaabbbbababbbbaabbbabaaaaabbabbbaabbaaabababaabbbbbbabbbab');
    receivedMessages.add('abbbbabbabbabbabbbabbbba');
    receivedMessages
        .add('baaaaaaabbbbabbbbaabbaaaaabbbbabbabbbbabababababaababaaa');
    receivedMessages.add('babbaaabababbbbbaaaaaaaa');
    receivedMessages.add(
        'abaabbaaaaabaabbababaaaaaaabbabababbbabaaabbabaabbbbbbabbabbaaaabbbbbbbb');
    receivedMessages.add('aaaabbbbbabbaaababbaaabbabababab');
    receivedMessages.add('bbbaabaaabbabbbbabbbbbbbbbaabbbbbbabbbbb');
    receivedMessages.add(
        'abbababbabaabbaabbabbabaaaabbbbbbbabaaabbbbbbbaaabbbaabbababaaaabaabaababababbbbbbbbbabb');
    receivedMessages.add('abbbbaabababbabbbbbbabbbbbbabbab');
    receivedMessages.add(
        'baabbaaababaabbbabbbabaaaababbbaababaabababbbaabaababbbbbaabbabb');
    receivedMessages.add(
        'abaabaabbabbaaaababbbbbbbbabbbaaaabbaaabbbbabbaaabbababbbbbbaaaa');
    receivedMessages.add('aabaabbabbbbaabababbbaab');
    receivedMessages.add('ababababbbaaaabaabbbabbbbbabaaab');
    receivedMessages.add(
        'aabbbabbbaaaaaaaaabaabaaaababaaabaabbbbaaaabaabaaaababaabbaaaaba');
    receivedMessages.add('bbaaaaaaababaabaabaaabab');
    receivedMessages.add(
        'bbbbbabaabbbaabaabbbbbbbaabbbaaababaabbbbbbababaabbbbbbbaaaaabbabbbbaaba');
    receivedMessages
        .add('bbabbababbaaabaabbbbbbbbaaaababaabbbabbabaaabbbabbbaabab');
    receivedMessages.add('aaaabaaabbbabbaaaaabbababaabaabb');
    receivedMessages.add('abbbaaaabbbbaaaabbbbbaab');
    receivedMessages.add('aaababbabbbbbbbaabbbbbbabaabaaba');
    receivedMessages.add('abaaaaaaaabaabbaabaaaaaabbababaaaabbabab');
    receivedMessages.add('aaababbaabbbaabbabbaabbbbbabbbaaabbabbabbbbabbab');
    receivedMessages.add('aabbaaaaabbbbababababbab');
    receivedMessages.add('abbaabababbababbbbbabbaabbbbaaab');
    receivedMessages.add('aaababbabbabaababbabbaab');
    receivedMessages
        .add('baabbbbbbbabbbabaabbbbaaaaaababbaaabaaabbabbbaabbbaaaaba');
    receivedMessages.add('babbaaababbababbbababaaababbabbabbbaabbbbabbbaab');
    receivedMessages.add('bbbaabbaaaaabaabababbaab');
    receivedMessages.add('bbbbbabaababbaabaababbbbaabbabba');
    receivedMessages.add('baaaaaabbaabbbabaabaabbabaabbaabbbabaabbbabaaaaa');
    receivedMessages.add(
        'ababaabbbbbaabbbbbbbabbaabbbaaaaabbaabbaababaaabbbbbbabbabaaaabb');
    receivedMessages.add('bbabbbbbbbaaaabaabababaa');
    receivedMessages.add('abaabaabaabaabaaabaaaaba');
    receivedMessages.add('aabbbbababaababaaabaaaaa');
    receivedMessages.add('baabaabaaaabaabababbbbaababbaaba');
    receivedMessages.add('bbaaaaaaababbbbbbabababbbababbba');
    receivedMessages.add('aababaabaabbbabaabbaabbbaababbababbaaaba');
    receivedMessages.add('ababaaabaaabababbaabbbbaaabbbaab');
    receivedMessages.add('abbaaaabababbababbabaabb');
    receivedMessages.add('babbbabbbaaababbaaabbaaaaaabaaabbbabbabb');
    receivedMessages.add('bbbbabbbbbbbbabbbbaababa');
    receivedMessages.add('bbbbabaabaabbabbaabbabaababbbbaa');
    receivedMessages.add('babaaaaabaaabbbbabbaabbbaabbabbbbbabbabb');
    receivedMessages.add(
        'bbbabbbaaabbbbaabbabaaabaaabbabbbaababbbbbabaababbbaaaabbaabbaab');
    receivedMessages.add(
        'baaaabbbabaabaaaabbbbaaaabbabaaaaabbabbbbbbbbbbbaabbabbbababababbaaabaabaabbabab');
    receivedMessages.add('abaabbabbababbbabbbababbbaababab');
    receivedMessages.add('abbbaabbbaaaababaaaaabbaabbabbbaaabaaaaa');
    receivedMessages.add('baaaabbaaaaabbbbabbbaaab');
    receivedMessages.add(
        'ababbabbbbabaaaabaabbabaaabaaabbaabbbaaaaababbaabaaabbbabbbbabba');
    receivedMessages.add(
        'abaababbbbaaaabaaaaaabbbaaaabababbaaababbabbbbaabbbbaaaaaabaababaabababbaabaababbaababab');
    receivedMessages
        .add('abbbaabaaaaabbbbabbbbaabbabbabababbbabaababbbbbaaababbbb');
    receivedMessages.add(
        'aaaabbaaaabaabbbbabbabbbbabbbabbbaaabbabbaabbaaaabbbabbbabaaaabbbaabbabababbbabbbaaabaaa');
    receivedMessages.add('aaabbaaabaabbbbbaabbabab');
    receivedMessages.add('babaabaaaabababaabbabbba');
    receivedMessages.add('bbbababbbababaaabbbaaaaaaaabaabbaabbbbbbaaabbbab');
    receivedMessages.add('abaabaaaabaaaababaabbaabbabaabba');
    receivedMessages.add('baababbbbbbbaababbaababbbbbbbbbababbbaababaaabba');
    receivedMessages.add('bbbbaaaaaaaaabbaaaabbbaa');
    receivedMessages.add('abbaababaabbbaaabbbbaaaaaababaabbabababa');
    receivedMessages.add('babbbabbababbabbbbbbaabb');
    receivedMessages.add(
        'aabaababaababbbaabbabbbbaaababababaabababbababaababbabbabbbaaaaabababbbabaaaaaaababaabbbabbbabbb');
    receivedMessages.add('bbabbaaabaaaabaaaaaaabaabbbbbbaabbbabbbaabaabbab');
    receivedMessages.add('aabbbabbbbaababbabababaababbbbaabbaaabbbaaabaaba');
    receivedMessages.add('aaaabaabbbbabbaabbbabaaa');
    receivedMessages.add('baabbabbababbbaabababbbabaaabaab');
    receivedMessages.add('bbabbbaaaaabbbbbabababbb');
    receivedMessages.add('aaabaaabbbaaaaabbbaabaaa');
    receivedMessages.add(
        'abaaabbbabbbbbaaaabbbbabbababaabaabbabbababaabbbabbbbaababbbbaab');
    receivedMessages.add(
        'babbabbbbaaaabababbbabbababababaabaabbaaaabababbababbbabbbbaabab');
    receivedMessages.add('bbaabbaaabbbaabbbbabbabb');
    receivedMessages.add('abbaabbaaabaaaaabaaabbbaabbbaaabaaaaaabb');
    receivedMessages.add('babaabbbabbbbbabbbbbabba');
    receivedMessages.add('aabbbbbaabbababbaaabaaabbaababaabaabbbaabbbababa');
    receivedMessages.add('bbbbbbaaabbbaabbaaaabbaababbbaab');
    receivedMessages.add('baaaaaaaababbabaabaaabab');
    receivedMessages.add('abbaababbaabbbababaabbab');
    receivedMessages.add('abbbabababbabbbbbabaabba');
    receivedMessages.add('bbbaabbbbbbbabbbaaabaaab');
    receivedMessages.add('bbbbababbbbaabbabbbbabbbbabbabbabbaabaaaaabbaabb');
    receivedMessages.add('abbaaabbaaaaabbabbbabbbb');
    receivedMessages.add('abbbbbbbbabbbababaaaaaaabaaabbba');
    receivedMessages.add('abbbbbbbbbaabbababaaaaab');
    receivedMessages.add('bbbbbbaabaaaabaabbbbbbabababaaaa');
    receivedMessages.add(
        'baabbbbaabbaabababbbaabaabbaaaabbbababaababaaabbbabaaababababaaa');
    receivedMessages.add('babbbabbaaababbabbbbabbbaaababbbaaaaaaaabbaaabbb');
    receivedMessages.add('aaabaaaaaabbbbbaaabaabbbbaaabaaa');
    receivedMessages.add('aabbbabbaaaaabbaabbbaaab');
    receivedMessages.add('baaabbaabbbaaabaabaaabaaabbbabbb');
    receivedMessages.add('bbbbbabbbbbaabaabbbbababbbaababa');
    receivedMessages.add('baaabbaaaabbbaabbaababab');
    receivedMessages
        .add('ababbbbaaabbaaababaaabaabbbaaabbaaabbaabaabababbaabbaabb');
    receivedMessages.add('babaaaaabaababaabbaaabaa');
    receivedMessages.add('bbabaaaaaaaabbaabbaababa');
    receivedMessages.add('bbabababaabbababbbaaaabababbaabb');
    receivedMessages.add('bbbabbaaabbaababbaababba');
    receivedMessages.add('bbaaabaabbbaaaababaaaaba');
    receivedMessages.add('aabbbbbbababaabaaabbbbbaaabbaaaaaabaabaa');
    receivedMessages.add(
        'aabaabaaaabaaaaaaaababaaababababbbaaabbababbaabbbbaaaababbbbabbbaabbbabaaaabbaba');
    receivedMessages.add(
        'bababbbabaabbbbbabbabaababbaaabaaaaaabbabababaababbbabaaaaaabbbbababbbaa');
    receivedMessages.add('baaaaabbabbbbbaabbbababbbababbab');
    receivedMessages.add('aaabaaabbaaababbbbabbbba');
    receivedMessages.add(
        'babaaaaaababaaababaaabbbbaaaabaaaababbbaaaabbbaaaaaaaababbabbababbbbaabbbabaabab');
    receivedMessages.add('abbbbbbbaababbababbbbbbbabaabababaabaaab');
    receivedMessages.add('baabbbbbbabaababaaaabaababaabaabbbaaabaa');
    receivedMessages.add('bbbabaababaaaabbabbaaaaaaaaabbaabababaaa');
    receivedMessages.add(
        'babbbbabbbabaabbabbabaabaaababbbaabbbabbaaaabbabbbaaaaaaababbaababaaaaaaaabbbababbbbabbb');
    receivedMessages.add('aaabaaabbbbbbbaaaaabaabbbaabaabb');
    receivedMessages.add('aaabbbbbababbabbabbbbbab');
    receivedMessages.add('aabaabbabaabaabbbbbbbbabbbaabbbb');
    receivedMessages.add('bbbaabbabbbbabbbbbbaaabaababbababababaabaaaabbba');
    receivedMessages
        .add('abbababaabbbaaaabbbbbabbaabaabaababbaabbaaabbbbabbbababa');
    receivedMessages
        .add('abbbbaabaaabaabbaaabaaabaaaaaaabaaaaaabaaabaabaaababaaab');
    receivedMessages.add('ababbababaaabbbbbbabbaaabababbba');
    receivedMessages.add('aaabbbbbabbaabbbabbbaababaaabbab');
    receivedMessages.add('bbbbaaaabaababaabbaaabaa');
    receivedMessages.add('ababbabbabbaaaaaabbaaaabaabbaabbbbabaabb');
    receivedMessages.add('abbabbbbbbaabaabababaaaaababbbab');
    receivedMessages.add(
        'baaaaabaaaabbabbaaaaababbaaaaaaaaabababababaaaaaaabaabaaababbbbb');
    receivedMessages.add('bbabaaabbaaaaabaaababaaaaaabbaababbabbab');
    receivedMessages
        .add('baaaaaabbabbbbaabbababbbaaaabbbbaaaaaaaabbababaaaaabbbba');
    receivedMessages.add(
        'baabbbbbbababaaaabbbbbaaabababbbbbaaabbbaaabbababbaabbbabaaaaaabbabbbaaaaabbaaba');
    receivedMessages.add('aaabbaaaabbaabbbbbabbabb');
    receivedMessages.add('aaabaabbababbabbaababaaa');
    receivedMessages.add('bbbbbaaaaabbbaaabaabbbabaabbaaba');
    receivedMessages.add('babaabbabbbbbbabababbbababaaabbabbbbbaba');
    receivedMessages.add('bbbaaaaaabbaaabbbabaaaabbbbabaaa');
    receivedMessages.add('aaaababbbabaababaaababab');
    receivedMessages.add('aaabbaaaaabbbaabbbabaaab');
    receivedMessages.add(
        'abbbbaaabaabbaaaaabbbabaaaabaaaabbbababbababbabababbbbaabbbbaababbbaaaaa');
    receivedMessages.add('bbaaaaaababbabaaababbaaaabababba');
    receivedMessages.add('bbabbbaabbbabaabbbaaabaa');
    receivedMessages.add('aabaaabbaabbbababbabaaaaaaabbbabaabbabaa');
    receivedMessages.add(
        'baaaaabbbbbbababbbabbbbbabaaabbbbbaaababbababbbaabababaaabbbabbbaaababba');
    receivedMessages.add(
        'babbbbbbababbaaaaabbabbaaabbababbbabaaabaabbbabaabaaababbabbabbabaaaaabbbaaabbbb');
    receivedMessages.add('abbbaabbaabbbaabbabbbbba');
    receivedMessages.add('abaaaabbaaabaaaaaabbabab');
    receivedMessages.add(
        'aaaaabbbbabbbabbbaababbababbaabababbabaababbaabbbbaaaababbabbabbaabaabaabbbbbaaaaabaaababbbbbaaa');
    receivedMessages.add('bbababbbbaaababababbbbab');
    receivedMessages.add('bbabbbabbbaaaaaaabbaabaa');
    receivedMessages.add(
        'bbbaaababaaababbbbbabbaaaabbabbaaaaaaaababbbaaabbaabbabbaaaaaaabaaaaaabb');
    receivedMessages.add('bbbbbabbababbabbbbbaaaaaaaabbababababababbababab');
    receivedMessages.add('ababbbbbaaababbaabaaaaaaabaaaaaabbbbbbba');
    receivedMessages.add('babbabbabaaabbbbbbaaabab');
    receivedMessages.add('bababbaabbaaaaabaaaaaabb');
    receivedMessages.add('bbbbbbbbabbaabbaabaabaaababaabaabaaaabbbaabbaaba');
    receivedMessages
        .add('baabbbbbbbbabababaabbaabababbbbbabbabaabbabbababaaabbbaa');
    receivedMessages.add('bbabbbaabbbbaaaaaabbabab');
    receivedMessages.add('aaaabaababbbbbbaaabbbabbababaabb');
    receivedMessages.add('aabbbbbaabbbbabaababaaab');
    receivedMessages.add('bbbaabaaaaabaaabbbabbbba');
    receivedMessages.add('babbaaabaabababbbababaaaabbabbabbbbabbba');
    receivedMessages.add('abaaaababaabbabbababaaaa');
    receivedMessages.add('bababaaaababbabbaabbaabb');
    receivedMessages.add('baaabbaaabbaababbbaaabab');
    receivedMessages.add('bbbbababbababaaabbbaabbaababaaba');
    receivedMessages.add(
        'abaabaaaaaabbbbbbbbbabbabababbbaababbaabbbabbababbaaababbbbabbbbbbabaaabaabababbababbbab');
    receivedMessages.add('aaaaaabaaababaabbbabbbbb');
    receivedMessages.add('abbbbbbbbaaaaabbbbaaaabb');
    receivedMessages.add('baabbbbaabbaaabbbaaababa');
    receivedMessages.add('baaabaaaabbaabaabbaaaaba');
    receivedMessages.add(
        'bbbbbaababbaaaabbaaababbabbbbbaaaaabbbabaababababaaaabbaaabaaaabbbabbbaa');
    receivedMessages.add('bbbbababbbabbaaabbbbaaababaabbababbbaaab');
    receivedMessages.add('aaabbaaabaaababbabaaabba');
    receivedMessages.add('babbabaaaaaabbaaabbabaab');
    receivedMessages.add('babbbbbaaaabbbabaabaababaabaaaabbaabbaaaaabbabbb');
    receivedMessages.add(
        'abbbbababbbbbababaaabaaabbbabaabbaabababbabbabaabbaaabbbaaaabbaaabaaaabaabbbaabb');
    receivedMessages.add('baabbbbbbbbababbbaababaaaaaabaababbabaab');
    receivedMessages.add('babbabbaabbbbbaaabbbaabbbbaabbbb');
    receivedMessages.add(
        'baaabaabbaaabbbbaaababaabbbababbaaaaabaabbaaabbaaabbababababbbba');
    receivedMessages.add('aabaabbabbaaabbabaabaabb');
    receivedMessages.add('bbbaabbababaaaaabbbbbbbaaabbaaba');
    receivedMessages.add('aaabbaaabaababbbababaabb');
    receivedMessages
        .add('bbabbbaabbaaababababababbbbbbabaaabaabbbaabaaaabababaabb');
    receivedMessages.add('abbbaabaabbababaababbaba');
    receivedMessages.add('bbababaaaabbbaaabaabbabb');
    receivedMessages.add('ababbabababababbbbaababa');
    receivedMessages.add('aabaaabbaababbabbabbbaaa');
    receivedMessages.add('aaaaababaabbbbaabbbaaaab');
    receivedMessages
        .add('aaaabbbbbbaaabbababbbbaabaaabaaababbbbaaababbbaabaabbbab');
    receivedMessages.add('abaababaabbbaaaabbbaaaba');
    receivedMessages.add('aaabbaabaaabbbababbbabbbbababbba');
    receivedMessages.add('baaabbaaabbababbbbbbabab');
    receivedMessages.add('bbaabbbbaaababababbaaaabbaabbaabaababbaa');
    receivedMessages
        .add('bbbaabbaaaaaabbbbbabaaabaabbbaaabbaabaaaabbaabababbbabbb');
    receivedMessages.add('bababbaaabbaaabbbbbababbbaabaaba');
    receivedMessages.add('baaaabbbbabaaabbbbaabbbb');
    receivedMessages.add('aabbaaaabbbbaaababaaaaba');
    receivedMessages
        .add('ababbbbbabbaabbbbbbbbaaaaaaaaaababbaaabbaabbaabbbbaabbba');
    receivedMessages.add('abaaaabbbbaabbaaaabbbaba');
    receivedMessages.add('bbaababbaaabaaaababbaaab');
    receivedMessages
        .add('abbbbabbaaababbaabbbbbbbbbbababbabaababbbbbbbabaababbabb');
    receivedMessages.add('baaababbbaababbbaabbaaba');
    receivedMessages.add(
        'babbaaaaaabaabaaabaaaaaabaabbbbbababaabaaaababaaaabbbaabaaabaaaa');
    receivedMessages.add(
        'baabbaaaababaabbaabbbbaaaabbabbbaaaaaaaabbbabbbbabbbaabababababbaabaabaabaabbaaa');
    receivedMessages.add('ababbbbbabbabbbbaababbbaaabababaababbbabbaaabaaa');
    receivedMessages.add('babbabaababbbabbbbbbaababaabbabb');
    receivedMessages.add('abaabbaababaaaababaabbabbaaaabaaabbabbaa');
    receivedMessages.add('baabbbbbaabbbabaaabbbbababbbaababbbbaabbabaaaaba');
    receivedMessages
        .add('bbbbbaababaaabaaaabaababbaaaaabbbabbbaabbaabbaabbbaababa');
    receivedMessages.add('bbaaaaabbbabaaaaabbababbbaabbababbabbbba');
    receivedMessages.add(
        'aaabaaabbaababbbbbbaaabaaababaabbbaabbbbabbabaaabaababbbaaaabaaabaaaaaba');
    receivedMessages.add('baabbababbabbabbabababbababbaabbbbabaaabbbbabbbb');
    receivedMessages.add('abbabbbbbbabaabaaaaababbaaabbbba');
    receivedMessages.add('abaaaaaabbbbbbaaaaabbabaabbaaabbbbbbbabbaaababaa');
    receivedMessages.add('bbabaabababbaaababbabaab');
    receivedMessages.add('aabababbaabaaabaaabaaaab');
    receivedMessages.add('abbaabbbababbbbabaabbaab');
    receivedMessages.add(
        'aabaaabaabaaabaaaaaabbbaabbabababaabbbbbaaaaabbabababbabbaaabbaabbbaaaaaabababab');
    receivedMessages.add('bbbbaababaaaabbabbaabaaa');
    receivedMessages.add('babbbabababbabaaaabaabbb');
    receivedMessages.add('abbbbbaaaaababbbbababbbb');
    receivedMessages.add('babbaabbbabababbaabbababbbabababaabaabaabaaabaab');
    receivedMessages.add('babbabbaabbbbbbabbababaababaabba');
    receivedMessages.add('abbabbabbbaabaababbababbbbabbababaabbbbb');
    receivedMessages.add('aabbababbaabbbabbbababab');
    receivedMessages.add('aaaaabbaababbbbaaabbaaba');
    receivedMessages.add('bbbbbaaabaaaabbababbaaabbaaabbbbbbbbaaabaaabaabb');
    receivedMessages.add('bbaababbaabbbaaabbbaabbabbaabbaababaaabbababbbaa');
    receivedMessages.add('abaaabbbbbababbbbbaababa');
    receivedMessages.add('bbbbbabbbaababaaabbbaabbbababbab');
    receivedMessages.add('abbababaabbbbbbaaaaaababaabbbbaaabbaabbabbaaabaa');
    receivedMessages.add('babbabaaaabaaabaabbabaabababaaab');
    receivedMessages.add('aaababababbaabaabbababbabbbababbaabbaaabbabaaabb');
    receivedMessages.add('ababbaabbabbbbaaababababbaaaabaaaabbabaa');
    receivedMessages.add('bbbaabbbabbabababaaaaaba');
    receivedMessages.add('aaaabaaaabaaaaaaaababbbb');
    receivedMessages.add('bbbaaabaaaaabaaabbaaaaba');
    receivedMessages.add('bababaaabbaabbabbaaabaaa');
    receivedMessages.add('abbbabbababaaabbbbbaaabababaabbbababbaaa');
    receivedMessages.add('aabbaaabbbbabbaabbababbb');
    receivedMessages.add('abbbababbbaaaaabaaaaabbbabaabbba');
    receivedMessages.add('bbbbabbbaaabbaaaaabaabababbabaabbabbbbbb');
    receivedMessages.add('bbbbbaaabaaaabbaaabbbaaabbbbababbaaaaabb');
    receivedMessages.add('babbaabbaabaabbaabbbabaaaaabaaaa');
    receivedMessages.add(
        'ababbababbbaaababbbaabaabbbbbaabaaaaabbbbaababbabbabbbbabbbaabab');
    receivedMessages.add('aabbbaabbbaababbbaaabbab');
    receivedMessages.add('baabaaaababaaaababaabbbb');
    receivedMessages.add('aaaababaabaabababbaaabab');
    receivedMessages.add('baabbabaabbbababbbbbbaaaabbbababbbaaaabb');
    receivedMessages.add('bbbabaaabbbbbaaabbbbaabbbbbabbabbbaababababababa');
    receivedMessages.add('aaaabbbbbaaaaabbbabbabbababbabbb');
    receivedMessages.add('babaabbbbaabbabababaaaaaaaaaaaaa');
    receivedMessages.add('abbabababaabbababbabbbbb');
    receivedMessages.add('aaabbbbbbabbabbaababbaaa');
    receivedMessages.add('babaabaaaabbbaaabbbaabba');
    receivedMessages.add(
        'bbbabbababbabaabbaaaaaabaababbaaabaabbbabbaaabbaaabaabaabbabbaababbbaabbbaaaababbbaaabbbbbabbbab');
    receivedMessages.add('ababbbbbaaaabaabaaababab');
    receivedMessages.add('abbaaabbaaaaabaabaababab');
    receivedMessages.add('bbbbbaaaabaaabaaaaabbabaababaaaa');
    receivedMessages.add('baabaaabbbbbbabbbabbabba');
    receivedMessages.add('bbbbbabbaaabaaabaaabbabb');
    receivedMessages.add('aabbaaaaabbbbbbabbaaaaababbaaaba');
    receivedMessages.add('abaaaaaaaababaababbbabaa');
    receivedMessages.add('bbbaaabaabaabaababbabbba');
    receivedMessages.add('aaaabbbbbaaabbbbaabbbbaaabaabaaa');
    receivedMessages
        .add('abbbabaaaabbbbabaaaaaaabbbbbaaaabaaaabbbaaaaabbabbaaabaa');
    receivedMessages.add('aaabbbbababbbbaabaabaababbbbaabbbaabbaab');
    receivedMessages.add('baaaaaaababaaabbbababbbb');
    receivedMessages.add('aaabbabaabbbbbbaaabbaabb');
    receivedMessages.add('aababbabbbbbbbbaaaababaa');
    receivedMessages.add('aabbaaaaaaaaaabaabbbababaababbbb');
    receivedMessages.add('abbabbbbaababbbaaabbbabbaaabbabaaaaabbab');
    receivedMessages.add('baababaaaababbbababbbaaa');
    receivedMessages.add('abbaaaaaaaabbbbbaababbab');
    receivedMessages.add('abaaaabbabbbaabbabaabbbb');
    receivedMessages.add('aaababbabbbbabbbaabaabbb');
    receivedMessages.add('baaaabbbbbbabaababababba');
    receivedMessages.add(
        'abbbbbbaabbbabaaabaaaaaaaabbaabaaabbabbbbbbbabbabbbaaaabababbbabbbbabbbb');
    receivedMessages.add('baababaababbbabaababaabb');
    receivedMessages.add('abaaabaabbaabbabbabaabbbaabaaaba');
    receivedMessages.add('aaaabbabaabbbbabaaabaabbaabaabbaabbbabba');
    receivedMessages
        .add('bababbaabbbaaabbbbaabbaabaababaabaaababaaaabababbaabbaab');
    receivedMessages.add('babbabbabaaaabaabababbba');
    receivedMessages.add('aaabaaaababaababbaaabbba');
    receivedMessages.add('baabaabbaaabbabaababababaabbaaaabababbab');
    receivedMessages.add('baaabbbbbaabbabaaabbbaab');
    receivedMessages.add(
        'aabbabaabaaabbaabbaaaabaabaaaabbbbabaabaaaabbbbaaaabbaabbabbbbaa');
    receivedMessages.add('aaaaaaaabbbababaabbbbaba');
    receivedMessages.add(
        'abbbabbaaaabaaabbbaaaaaabbbbabbbabbbababbaabaabaabbabbaabaabaabaabaaabbb');
    receivedMessages.add('abbbabaaaabababaabbabbbbabbbabbb');
    receivedMessages.add('bbbbbbbbababbbbaaabaaaba');
    receivedMessages.add('aabbaaaaaababababaaaabbabbbbaabb');
    receivedMessages.add('babbbabbbbbaaababababbbb');
    receivedMessages.add('bbbbbaaababaabbbababbbaabababaab');
    receivedMessages.add('abbbbaabbbbaaaaabbaababbabaabaaa');
    receivedMessages.add('abbbababbbaabbabbbbbabba');
    receivedMessages.add('abbbabaababbbabbabbbbaaa');
    receivedMessages
        .add('bbabbabababaaaabbaaaabbbbaaaaaabbaabbbbaaabbbbbabaabbbba');
    receivedMessages.add('abbbababbababbaabbaababbaaaaabbbbaaaaaabbaabbbba');
    receivedMessages.add('bbabaabbbbbbbbabbaabbbabbaabbaabaababbbb');
    receivedMessages.add('aaaaabaabaababbbabbaababbbbaaabaabbaaaab');
    receivedMessages.add('bbbbbbbbaaaaaabbaababbaaababaaab');
    receivedMessages.add('abbbabaaaaaabbaabbbaaaab');
    receivedMessages.add('bbababaaabbbaabaabababab');
    receivedMessages.add('aaababbabbbbbaabbbbbaabb');
    expect(answer2(), 124); // fails here...
  });

  test('part of string equal', () {
    expect(comparePart('abcd', 'abcde'), true);
    expect(comparePart('sabcd', 'abcde'), false);
    expect(comparePart('foo', 'foobar'), true);
    expect(comparePart('first', 'first'), true);
    expect(comparePart('firsta', 'first'), false);
    List strings = ['one', 'two', 'three'];
    strings.remove('one');
    print('Strings: $strings');
  });
}
