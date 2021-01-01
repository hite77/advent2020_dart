import 'dart:convert';
import 'dart:core';
import 'dart:io';

Map<int, String> rules = new Map();
List<String> receivedMessages = [];

List build(String source) {
  // print('Build: $source');
  List newStrings = [];
  // 1 to N... number --> and together....
  // # # | # # --> look up strings for each and add both results
  // "a" -->
  if (source.contains('|')) {
    List<String> items = [];
    source.split(' ').forEach((element) {
      if (element != '|') {
        items.add(element);
      }
    });
    // combine these together properly and see if 8 results....

    if (items.length == 2) {
      List first = build(rules[int.parse(items[0])]);
      List second = build(rules[int.parse(items[1])]);
      for (int i = 0; i < first.length; i++) {
        newStrings.add(first[i]);
      }
      for (int j = 0; j < second.length; j++) {
        newStrings.add(second[j]);
      }
    }
    if (items.length == 4) {
      List first = build(rules[int.parse(items[0])]);
      List second = build(rules[int.parse(items[1])]);
      for (int i = 0; i < first.length; i++) {
        for (int j = 0; j < second.length; j++) {
          newStrings.add(first[i] + second[j]);
        }
      }
      List third = build(rules[int.parse(items[2])]);
      List fourth = build(rules[int.parse(items[3])]);
      for (int i = 0; i < third.length; i++) {
        for (int j = 0; j < fourth.length; j++) {
          newStrings.add(third[i] + fourth[j]);
        }
      }
    }
  } else if (source.contains(' ')) {
    List<List> buildPieces = [];
    source.split(' ').forEach((element) {
      buildPieces.add(build(rules[int.parse(element)]));
    });

    // combine buildPieces into newList...
    buildPieces.forEach((pieces) {
      if (newStrings.length == 0) {
        pieces.forEach((element) {
          newStrings.add(element);
        });
      } else {
        int originalLength = newStrings.length;
        for (int j = 0; j < originalLength; j++) {
          var originalValue = newStrings[j];
          for (int i = 0; i < pieces.length; i++) {
            if (i == 0) {
              newStrings[j] += pieces[i];
            } else {
              newStrings.add(originalValue + pieces[i]);
            }
          }
        }
      }
    });
  } else if (source.contains(new RegExp(r'[0-9]+'))) {
    return build(rules[int.parse(source)]);
  } else {
    newStrings = [source];
  }
  return newStrings;
}

List getStrings() {
  return build(rules[0]);
}

void readLine(String line) {
  // print('Line: $line');
  // ignore blank lines...
  if (line == '') {
    return;
  }
  // strings that don't match go to receivedMessages
  RegExp exp = new RegExp(r"^([0-9]+): (.*)$");
  Iterable<Match> matches = exp.allMatches(line);
  if (matches.length > 0) {
    if (line.contains('"')) {
      rules[int.parse(matches.elementAt(0).group(1))] =
          matches.elementAt(0).group(2)[1];
    } else {
      rules[int.parse(matches.elementAt(0).group(1))] =
          matches.elementAt(0).group(2);
    }
  } else {
    receivedMessages.add(line);
  }
  // int.parse(matches.elementAt(0).group(2));
  // read 0: rule string....
}

List combine(List<List> strings) {
  List newstring = [];
  strings.forEach((list) {
    list.forEach((element) {
      newstring.add(element);
    });
  });
  return newstring;
}

bool comparePart(String first, String second) {
  return second.contains(first);
}

int andTogether(String items, List items42, List items31, List messages,
    List matchedMessages) {
  print(items);
  var strings = [];
  var removeStrings = [];
  var addStrings = [];

  var itemsSplit = items.split(' ');
  var first = itemsSplit.first;
  itemsSplit.remove(first);

  if (first == '42') {
    items42.forEach((element) {
      var found = false;
      messages.forEach((message) {
        if (comparePart(element, message)) {
          found = true;
        }
      });
      if (found) {
        strings.add(element);
      }
    });
  } else {
    items31.forEach((element) {
      var found = false;
      messages.forEach((message) {
        if (comparePart(element, message)) {
          found = true;
        }
      });
      if (found) {
        strings.add(element);
      }
    });
  }

  for (int i = 0; i < itemsSplit.length; i++) {
    var element = itemsSplit[i];
    addStrings.forEach((element) {
      strings.add(element);
    });
    addStrings = [];
    removeStrings.forEach((element) {
      strings.remove(element);
    });
    removeStrings = [];
    var endStrings = strings.length;
    for (int j = 0; j < endStrings; j++) {
      var possible = strings[j];
      removeStrings.add(possible);
      if (element == '42') {
        items42.forEach((element) {
          for (int k = 0; k < messages.length; k++) {
            var message = messages[k];
            if (comparePart(possible + element, message)) {
              if (!addStrings.contains(possible + element)) {
                addStrings.add(possible + element);
                print(
                    'adding: ${possible + element} --> $items:$i:${strings.length}:${removeStrings.length}');
              }
              if ((possible + element == message) &&
                  (i == itemsSplit.length - 1)) {
                // removeMessages.add(message);
                // messages.remove(message);
                // k -= 1;
                if (!matchedMessages.contains(message)) {
                  matchedMessages.add(message);
                }
                print(
                    'count: ${matchedMessages.length}  , messages count: ${messages.length} --> $items:$i:${messages.length}');
              }
            }
          }
        });
      } else {
        items31.forEach((element) {
          for (int k = 0; k < messages.length; k++) {
            var message = messages[k];
            if (comparePart(possible + element, message)) {
              if (!addStrings.contains(possible + element)) {
                addStrings.add(possible + element);
                print('adding: ${possible + element} --> $items');
              }
              if ((possible + element == message) &&
                  (i == itemsSplit.length - 1)) {
                // messages.remove(message);
                // k -= 1;
                if (!matchedMessages.contains(message)) {
                  matchedMessages.add(message);
                }
                print(
                    'count: ${matchedMessages.length} , messages count: ${messages.length} --> $items:$i:${messages.length}');
              }
            }
          }
        });
      }
    }
  }
  return matchedMessages.length;
}

int answer2() {
  // // 8: 42 | 42 8
  // // 11: 42 31 | 42 11 31
  // // need to handle one term and two on the right....
  // // and 2 on the left and 3 on the right....
  // // answer2 version of build.... and have it handle 8 and 11 differently.
  // // 8 was just 42.... and 0: is 8 and 11....
  // // 42 is:
  // rules[8] = '42 | 42 8';
  // rules[11] = '42 31 | 42 11 31';
  // build out strings....
  var items42 = [
    'bbbbbbaa',
    'bbabbbaa',
    'bbbabbaa',
    'bbaabbaa',
    'bababbaa',
    'baaabbaa',
    'babbabaa',
    'baababaa',
    'babaabaa',
    'baaaabaa',
    'bbbaabaa',
    'bbababaa',
    'bbabbaaa',
    'bbbbbaaa',
    'bababaaa',
    'baabbaaa',
    'babaaaaa',
    'baabaaaa',
    'baaaaaaa',
    'bbbbaaaa',
    'bbabaaaa',
    'bbbaaaaa',
    'bbaaaaaa',
    'baabbaba',
    'babbbaba',
    'baaaabba',
    'babbabba',
    'bbbbaaba',
    'bbbaaaba',
    'bbabaaba',
    'bbbbbbba',
    'bbbabbba',
    'bbbaabba',
    'bbababba',
    'bbaaabba',
    'abbbbbaa',
    'abbbabaa',
    'abbbaaaa',
    'abbaaaaa',
    'abaaaaaa',
    'abaaabaa',
    'abbbbbba',
    'abbbabba',
    'abbbaaba',
    'abbababa',
    'ababbbba',
    'ababbaba',
    'abaababa',
    'aaaababa',
    'aaaaabba',
    'aaaaaaba',
    'aaaabbaa',
    'aaaabaaa',
    'aaaaabaa',
    'aaabbaaa',
    'aaabbaba',
    'aaabaaaa',
    'aaababba',
    'aababbba',
    'aabababa',
    'aabaabba',
    'aabbbbba',
    'aabbbaba',
    'aabaabaa',
    'aabbbbaa',
    'aabbbaaa',
    'aabbaaaa',
    'abbabbbb',
    'abbaabbb',
    'abbababb',
    'abbaaabb',
    'abbbaabb',
    'abbbbbbb',
    'ababbbbb',
    'ababbabb',
    'abaaaabb',
    'aaabbbbb',
    'aaaabbbb',
    'aaababbb',
    'aaaaabbb',
    'aaabaabb',
    'aaaababb',
    'aabaaabb',
    'aabbbabb',
    'bbaababb',
    'bbbbbbbb',
    'bbbbbabb',
    'bbbbabbb',
    'bbbababb',
    'bbbaabbb',
    'bbbaaabb',
    'babaabbb',
    'baabbbbb',
    'baaabbbb',
    'baababbb',
    'baaaabbb',
    'babaaabb',
    'baaaaabb',
    'babbbabb',
    'babababb',
    'baaababb',
    'baaaabab',
    'babbabab',
    'babaabab',
    'bbaabbab',
    'bbabbbab',
    'bbbbabab',
    'abbbabab',
    'abbaabab',
    'aabbbbab',
    'aababbab',
    'aabaabab',
    'aaaaabab',
    'bbbbbaab',
    'bbbabaab',
    'babbaaab',
    'babaaaab',
    'bbaaaaab',
    'bbbbaaab',
    'aaaaaaab',
    'abbaaaab',
    'aaabaaab',
    'aabbaaab',
    'aabbbaab',
    'abbbbaab',
    'abaabaab',
    'aababaab',
    'aaaabaab'
  ];
  print('42:$items42');
  var items31 = [
    'abbbbaba',
    'abbbbaaa',
    'abbbbabb',
    'abbbabbb',
    'abbbaaab',
    'abbbbbab',
    'abbabbab',
    'abbabaab',
    'abbabbba',
    'abbabbaa',
    'abbabaaa',
    'abbaabba',
    'abbaabaa',
    'abbaaaba',
    'ababbbaa',
    'abababaa',
    'ababbaaa',
    'ababaaaa',
    'abaabbaa',
    'abaabaaa',
    'abababba',
    'abaabbba',
    'abaaabba',
    'ababaaba',
    'abaaaaba',
    'ababbbab',
    'abaabbab',
    'abababab',
    'abaaabab',
    'ababbaab',
    'ababaaab',
    'abaaaaab',
    'ababaabb',
    'abaababb',
    'abababbb',
    'abaabbbb',
    'abaaabbb',
    'aaaaaaaa',
    'aaaaaabb',
    'aaaabbba',
    'aaaabbab',
    'aaabbaab',
    'aaabbabb',
    'aaabbbba',
    'aaabbbab',
    'aaabbbaa',
    'aaababaa',
    'aaababab',
    'aaabaaba',
    'aabbabaa',
    'aabbaaba',
    'aabbabba',
    'aababbaa',
    'aababaaa',
    'aabaaaaa',
    'aabaaaba',
    'aabbbbbb',
    'aababbbb',
    'aabbabbb',
    'aabaabbb',
    'aabbaabb',
    'aabababb',
    'aabaaaab',
    'aabbabab',
    'bbbbbbab',
    'bbbabbab',
    'bbbaabab',
    'bbababab',
    'bbaaabab',
    'bababbab',
    'babbbbab',
    'baabbbab',
    'baababab',
    'baaabbab',
    'babbbaab',
    'baabbaab',
    'bababaab',
    'baaabaab',
    'baaaaaab',
    'baabaaab',
    'bbbaaaab',
    'bbabbaab',
    'bbabaaab',
    'bbaabaab',
    'bbbabbbb',
    'bbaabbbb',
    'bababbbb',
    'bbabbbbb',
    'babbbbbb',
    'bbaaabbb',
    'bbababbb',
    'babbabbb',
    'bbaaaabb',
    'bbbbaabb',
    'babbaabb',
    'bbabaabb',
    'baabaabb',
    'baabbabb',
    'bbabbabb',
    'bbaaabaa',
    'bbbbabaa',
    'bbaabaaa',
    'bbbabaaa',
    'babbbaaa',
    'babbaaaa',
    'baaabaaa',
    'baabbbaa',
    'babbbbaa',
    'babbaaba',
    'baabaaba',
    'babaaaba',
    'baaaaaba',
    'babababa',
    'baaababa',
    'babbbbba',
    'baabbbba',
    'bababbba',
    'baaabbba',
    'babaabba',
    'baababba',
    'bbbbbaba',
    'bbabbaba',
    'bbbababa',
    'bbaababa',
    'bbaaaaba',
    'bbaabbba',
    'bbabbbba',
    'bbbbabba'
  ];
  print('31:$items31');
  List matchedMessages = [];

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

  // var maxLength = 0;
  // receivedMessages.forEach((element) {
  //   if (element.length > maxLength) {
  //     maxLength = element.length;
  //   }
  // });
  // print('maxLength: $maxLength');
  return matchedMessages.length;
}

int answer() {
  // return build(rules[0]);
  // print('42: ${build(rules[42])}');
  // print('31: ${build(rules[31])}');

  // call getStrings and start building for rule 0....
  var count = 0;
  var maxLength = 0;
  var maxRule = 0;

  rules.keys.forEach((element) {
    if (element > maxRule) {
      maxRule = element;
    }
  });
  final strings = getStrings();
  receivedMessages.forEach((message) {
    if (message.length > maxLength) {
      maxLength = message.length;
    }
    strings.forEach((element) {
      if (message == element) {
        count += 1;
      }
    });
  });
  print('Maxlength message: $maxLength MaxRule: $maxRule');
  return count;
}

// During a cycle, all cubes simultaneously change their state according to the following rules:
//
// If a cube is active and exactly 2 or 3 of its neighbors are also active, the cube remains active. Otherwise, the cube becomes inactive.
// If a cube is inactive but exactly 3 of its neighbors are active, the cube becomes active. Otherwise, the cube remains inactive.

void main() async {
  var file = File('data.txt');
  if (await file.exists()) {
    var contentStream = file.openRead();
    contentStream.transform(Utf8Decoder()).transform(LineSplitter()).listen(
        (String line) => readLine(line),
        onDone: () => print('part2Answer: ${answer2()}'),
        onError: (e) => print('$e'));
  }
}
