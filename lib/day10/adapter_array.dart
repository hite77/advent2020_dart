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
int valid = 1;

List<int> values_between(startValue, endValue) {
  List<int> returnValue = [];
  for (final value in jolts) {
    if ((value > startValue) && (value < endValue)) {
      returnValue.add(value);
    } else if (value == endValue) {
      break;
    }
  }
  return returnValue;
}

bool validList(List list) {
  // start + on items + end --> changes are 3 or less
  var valid = true;
  var currentValue = list[0];
  for (var i = 1; i < list.length; i++) {
    if ((list[i] - currentValue) > 3) {
      valid = false;
      break;
    }
    currentValue = list[i];
  }
  print('valid:$valid');
  return valid;
}

String calculateStringCounter(counter, valuesBetween) {
  var short_string = counter.toRadixString(2);
  String counter_string =
      '0' * (valuesBetween.length - short_string.length) + short_string;
  return counter_string;
}

int validPossibilities(start_value, end_value, List valuesBetween) {
  var counter = 0;
  var validOnes = 0;

  if (valuesBetween.length == 0) {
    return 1;
  }
  // use a counter that is the length of valuesbetween, turn on and off the values put start and end to the end.....

  while (true) {
    List<int> check_this = [start_value];
    var counterString = calculateStringCounter(counter, valuesBetween);

    print('counter:$counterString');

    for (int i = 0; i < counterString.length; i++) {
      if (counterString[i] == '1') {
        check_this.add(valuesBetween[i]);
      }
    }
    check_this.add(end_value);
    print('trying: $check_this');
    if (validList(check_this)) {
      validOnes += 1;
    }

    if (calculateStringCounter(counter, valuesBetween) ==
        '1' * valuesBetween.length) {
      break;
    }

    counter += 1;
  }
  return validOnes;
}

int all_answer_count() {
  // new way to solve....

  // build counterString then bump by 1's (groups must be 1)

  print('length: ${diffThreeAlways.length} diff3:${diffThreeAlways}');
  print('length: ${diffOneAlways.length} diff1:${diffOneAlways}');
  print('length:${jolts.length} jolts:$jolts');

  // multiply valid by each count....
  var current_position_start = 0;
  var start_value = 0;
  var end_value = diffThreeAlways[current_position_start];

  while (current_position_start < diffThreeAlways.length) {
    // find ways to get from start value to end value....
    List<int> valuesBetween = values_between(start_value, end_value);
    // if no values continue on....
    if (valuesBetween == []) {
      // nop for now... going to proceed after calculating new start and end...
    } else {
      // calculate how many possibilities....
      valid *= validPossibilities(start_value, end_value, valuesBetween);
      print(
          'start: $start_value : values are: $valuesBetween : end: $end_value : current_possibilities: $valid');
    }
    // advance on
    start_value = end_value;
    current_position_start++;
    if (current_position_start < diffThreeAlways.length) {
      end_value = diffThreeAlways[current_position_start];
    }
  }

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
