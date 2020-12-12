import 'dart:convert';
import 'dart:core';
import 'dart:io';

List<int> jolts = [];
int largest_jolt = 0;
int count_one_diff = 0;
int count_three_diff = 0;
int current = 0;

registerJolt(String line) {
  int value = int.parse(line);
  if (value > largest_jolt) {
    largest_jolt = value;
  }
  jolts.add(value);
}

List<int> diffThreeAlways = [];
List<int> diffOneAlways = [];
List<int> positionEndOfGroups = [];
int counter = 0;
int valid = 0;

is_valid_increment(String counter) {
  // build trythis from all of diffthree, and 1's from counter....
  List<int> tryThis = List.from(diffThreeAlways);
  for (var i = 0; i < counter.length; i++) {
    if (counter[i] == '1') {
      // print('Set: $i + value:${diffOneAlways[i]}');
      tryThis.add(diffOneAlways[i]);
    }
  }
  tryThis.sort();
  // print('looking at: $tryThis');
  var current = 0;
  var isValid = true;
  for (final element in tryThis) {
    if (element - current > 3) {
      isValid = false;
      break;
    }
    current = element;
  }
  ;
  if (isValid) {
    valid += 1;
  }
}

String bumpByOnes(String rawCounter) {
  List<String> revisions = [];
  revisions.add(rawCounter);
  positionEndOfGroups.forEach((element) {
    if (revisions.last.substring(element - 2, element + 1) == '000') {
      revisions.add(revisions.last.substring(0, element - 2) +
          '001' +
          revisions.last.substring(element + 1));
      print(revisions.last);
    }
  });

  return revisions.last;
}

void constructPositionEndOfGroups() {
  positionEndOfGroups = [
    4,
    10,
    13,
    16,
    19,
    24,
    29,
    34,
    38,
    41,
    45,
    48,
    51,
    55,
    61,
    65,
    68
  ];
  // jolts contains all the numbers.... needs to be three 1's in a row...
//6, 7, 8 reset count to zero
  //if it jumps more than 1 clear count
  //13, 14, 15
  //position in jolts.
  // diffOneAlways = [1,2,6,7,8,9,13,14,15,16];
  // jolts = [1,2,5,6,7,8,9,13,14,15,16];
  // var countTogether = 0;
  // var lastElement = 0;
  // // var currentIndex = 1;
  // diffOneAlways.forEach((element) {
  //   if (element - lastElement == 1) {
  //     countTogether += 1;
  //     if (countTogether == 3) {
  //       countTogether = 0;
  //       positionEndOfGroups.add(jolts.indexOf(element) - 1);
  //     }
  //   } else {
  //     countTogether = 1;
  //   }
  //   lastElement = element;
  // });
  // print('diffOneAlways: $diffOneAlways');
  // print('endOfGroups: $positionEndOfGroups : length_jolt: ${jolts.length}');
  // positionEndOfGroups.forEach((element) {
  //   print('end group number: ${jolts[element]}');
  // });
}

// 1, 2, or 3 lower than value....
int all_answer_count() {
  jolts.add(largest_jolt + 3);
  jolts.sort();

  // new way to solve....
  // need to count only where the 1's are....
  // also at least of each group of 1's will need to be 1....

  // construct positionEndOfGroups contains position of each group
  // walk jolts, identify three in a row of 1's that are not three's....
  constructPositionEndOfGroups();

  // build counterString then bump by 1's (groups must be 1)
  var counterString = bumpByOnes('0' * diffOneAlways.length);
  print('length of counter bits: ${counterString.length}');

  counter = int.parse(counterString, radix: 2);
  print('position: 1=> ${jolts.indexOf(1)}');
  print('position: 2=> ${jolts.indexOf(2)}');
  print(
      'end of groups => [${diffOneAlways.indexOf(8)},${diffOneAlways.indexOf(20)},${diffOneAlways.indexOf(29)},${diffOneAlways.indexOf(35)},${diffOneAlways.indexOf(41)},${diffOneAlways.indexOf(55)},${diffOneAlways.indexOf(66)},${diffOneAlways.indexOf(77)},${diffOneAlways.indexOf(87)},${diffOneAlways.indexOf(93)},${diffOneAlways.indexOf(100)},${diffOneAlways.indexOf(106)},${diffOneAlways.indexOf(112)},${diffOneAlways.indexOf(119)},${diffOneAlways.indexOf(131)},${diffOneAlways.indexOf(141)},${diffOneAlways.indexOf(150)}]');

  print('CounterString: $counterString : int counter: $counter');
  //counter = // update the counter variable to match the new counter

  // print('length:${jolts.length}');
  // var counterString = '0' * diffOneAlways.length;
  // print(counterString);
  // call the function for all zero....
  // is_valid_increment(counterString);

  // while (counterString != '1' * diffOneAlways.length) {
  //   counter++;
  //   var count_string = counter.toRadixString(2);
  //   counterString =
  //       '0' * (diffOneAlways.length - count_string.length) + count_string;
  // if I perform the opp here... then at least the first bit will be set....
  // print(counterString);
  // is_valid_increment(counterString);
  // print('counter: $counterString :Count currently: $valid');
  //
  return valid;
}

int answer() {
  // need to add one that is 3 above highest
  jolts.add(largest_jolt + 3);
  diffThreeAlways.add(largest_jolt + 3);
  jolts.sort();

  print(jolts);

  jolts.forEach((element) {
    if (element - current == 1) {
      // print('one diff:$current');
      diffOneAlways.add(element);
      count_one_diff += 1;
    } else if (element - current == 3) {
      // print('three diff:$current');
      diffThreeAlways.add(element);
      count_three_diff += 1;
    }
    current = element;
  });
  // print('count of three diff: $count_three_diff');
  // print(jolts);
  return count_one_diff * count_three_diff;
}

void main() async {
  print('adapter array');
  var file = File('data.txt');
  if (await file.exists()) {
    var contentStream = file.openRead();
    contentStream.transform(Utf8Decoder()).transform(LineSplitter()).listen(
        (String line) => registerJolt(line),
        onDone: () => print('Answer:${answer()} part2: ${all_answer_count()}'),
        onError: (e) => print('$e'));
  }
}
