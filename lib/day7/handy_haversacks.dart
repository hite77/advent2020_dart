import 'dart:convert';
import 'dart:core';
import 'dart:io';

var bag_details = new Map();
var bag_count_details = new Map();
int count_shiny_bags = 0;
int count_bags_inside = 0;
bool found_one = false;

String left_side(line) {
  RegExp exp = new RegExp(r"(.*) bags contain.*$");
  Iterable<Match> matches = exp.allMatches(line);
  if (matches.length > 0) {
    return matches.elementAt(0).group(1);
  }
  return 'notMatched';
}

Map right_count_side(line) {
  RegExp exp = new RegExp(r".* contain (.*)$");
  Iterable<Match> matches = exp.allMatches(line);
  Map right = new Map();

  if (matches.length > 0) {
    var containsMatches = matches.elementAt(0).group(1);
    containsMatches.split(', ').forEach((element) {
      print('element:$element');
      RegExp itemExp = new RegExp(r"^([0-9]+) (.*) bag.*$");
      Iterable<Match> innerMatches = itemExp.allMatches(element);
      right[innerMatches.elementAt(0).group(2)] =
          innerMatches.elementAt(0).group(1);
    });
  }
  return right;
}

List<dynamic> right_side(line) {
  RegExp exp = new RegExp(r".* contain (.*)$");
  Iterable<Match> matches = exp.allMatches(line);
  List right = [];

  if (matches.length > 0) {
    var containsMatches = matches.elementAt(0).group(1);
    containsMatches.split(',').forEach((element) {
      RegExp itemExp = new RegExp(r"^.*(?:[0-9]+ )(.*) bag.*$");
      Iterable<Match> innerMatches = itemExp.allMatches(element);
      right.add(innerMatches.elementAt(0).group(1));
    });
  }
  return right;
}

bool filter(line) {
  RegExp exp =
      new RegExp(r".*( contain no other bag|shiny gold bags contain).*$");
  Iterable<Match> matches = exp.allMatches(line);
  return matches.length > 0;
}

void parse(line) {
  // place unfiltered lines into map....
  if (!filter(line)) {
    bag_details[left_side(line)] = right_side(line);
  }
}

void parse_number(line) {
  // no filter -- right side needs name and count.... list of maps? or just a map.
  RegExp exp = new RegExp(r".* contain no other bag.*$");
  Iterable<Match> matches = exp.allMatches(line);
  if (matches.length == 0) {
    bag_count_details[left_side(line)] = right_count_side(line);
  }
}

bool count_it(element) {
  print('count_it:$element');
  if (element == null) {
    return false;
  }
  if (element == ['shiny gold']) {
    print('found one');
    // count_shiny_bags += 1;

    found_one = true;
    return true;
  }
  if (element is List) {
    element.forEach((element) {
      if (element == 'shiny gold') {
        found_one = true;
        return true;
      }
    });
  }
  if (element is List) {
    element.forEach((element) {
      return count_it(bag_details[element]);
    });
  }
  return count_it(bag_details[element]);
}

int count_inside_bags(item) {
  print('count inside:$item');
  if (item == null) {
    return 0;
  }
  if (item is Map) {
    // returning might not get all...
    int localsum = 0;
    item.keys.forEach((element) {
      if (bag_count_details[element] == null) {
        localsum += int.parse(item[element]);
      } else {
        localsum += int.parse(item[element]) +
            int.parse(item[element]) *
                count_inside_bags(bag_count_details[element]);
      }
    });
    return localsum;
  }
}

int count_number() {
  //count_bags_inside
  // print it out....
  print(bag_count_details);
  print(bag_count_details['shiny gold']);
  Map items = bag_count_details['shiny gold'];
  items.keys.forEach((element) {
    print('keys in count number:$element');
    print(
        'what is this:${int.parse(bag_count_details['shiny gold'][element]) + int.parse(bag_count_details['shiny gold'][element]) * count_inside_bags(bag_count_details[element])}');
    count_bags_inside = count_bags_inside +
        int.parse(bag_count_details['shiny gold'][element]) +
        int.parse(bag_count_details['shiny gold'][element]) *
            count_inside_bags(bag_count_details[element]);
  });
  print('Answer: $count_bags_inside');
  return count_bags_inside;
}

int count() {
  print('bag_details: ${bag_details}');

  bag_details.keys.forEach((element) {
    print('element:$element checking:${bag_details[element]}');
    count_it(bag_details[element]);
    if (found_one) {
      print('adding one at top');
      count_shiny_bags += 1;
      found_one = false;
    }
  });

  // print it out....
  print('Answer: $count_shiny_bags');
  return count_shiny_bags;
}

void main() async {
  print('handy haversacks');
  var file = File('data.txt');
  if (await file.exists()) {
    var contentStream = file.openRead();
    contentStream.transform(Utf8Decoder()).transform(LineSplitter()).listen(
        (String line) => parse_number(line),
        onDone: () => count_number(),
        onError: (e) => print('$e'));
  }
}
