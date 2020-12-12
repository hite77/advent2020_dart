import 'dart:convert';
import 'dart:core';
import 'dart:io';

// need a buffer of 25.... roll off the last one
// each new number make sure and check if sum of any two
// different numbers...
// list of 25 ints, and rotate the insert...
// 0-24 then 0-24.....

List preamble = new List(25);
bool foundIt = false;
int invalid_value = null;
int insertionPoint = 0;
bool filled = false;

bool is_invalid(int goal) {
  bool none_matched = true;
  for (var i = 0; i < 25; i++) {
    for (var j = 0; j < 25; j++) {
      if (i == j) {
        j = j + 1;
        if (j == 25) {
          i = i + 1;
          j = 0;
        }
      }
      if ((i < 25) && (j < 25)) {
        if (preamble[i] + preamble[j] == goal) {
          none_matched = false;
          break;
        }
      }
    }
  }
  return none_matched;
}

look_for_invalid(line) {
  int new_value = int.parse(line);
  if (!foundIt) {
    if (filled && is_invalid(new_value)) {
      foundIt = true;
      invalid_value = new_value;
    }
    preamble[insertionPoint] = new_value;
    insertionPoint++;
    if (!filled && insertionPoint == 25) {
      filled = true;
    }
    if (insertionPoint == 25) {
      insertionPoint = 0;
    }
  }
}

List all_numbers = [];
int top_index = 0;
int current_index = 0;
int bottom_index = 0;

build_table(line) {
  all_numbers.add(int.parse(line));
}

output_results() {
  // sum down the line for target......
  const target = 507622668;
  int sum = 0;

  while (sum != target) {
    sum = 0;
    current_index = top_index;
    while (sum < target) {
      sum += all_numbers[current_index];
      if (sum < target) {
        print('current index: $current_index');
        current_index++;
      }
    }
    if (sum != target) {
      top_index += 1;
      print('top index:$top_index of ${all_numbers.length}');
    }
  }

  if (sum == target) {
    // calculate smallest and highest numbers....
    var small = all_numbers[top_index];
    var large = all_numbers[top_index];
    for (var i = top_index; i <= current_index; i++) {
      if (all_numbers[i] < small) {
        small = all_numbers[i];
      }
      if (all_numbers[i] > large) {
        large = all_numbers[i];
      }
    }
    print('smallest number:$small, largest number:$large');
    print('top index:$top_index, current index:$current_index');
    print('answer:${small + large}');
  }
}

void main() async {
  print('encoding error');
  var file = File('data.txt');
  if (await file.exists()) {
    var contentStream = file.openRead();
    contentStream.transform(Utf8Decoder()).transform(LineSplitter()).listen(
        (String line) => build_table(line),
        onDone: () => output_results(),
        onError: (e) => print('$e'));
  }
}
