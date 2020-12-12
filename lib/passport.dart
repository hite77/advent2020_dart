import 'dart:convert';
import 'dart:core';
import 'dart:io';

class Status {
  static int valid_count;
  static String passport;
}

// byr (Birth Year)
// iyr (Issue Year)
// eyr (Expiration Year)
// hgt (Height)
// hcl (Hair Color)
// ecl (Eye Color)
// pid (Passport ID)
// cid (Country ID) ignore this one...

int extract_string_four_digit(keyword) {
  RegExp exp = new RegExp(r"(?:^|.* )" + keyword + r":([0-9]{4})(?: |$)");
  Iterable<Match> matches = exp.allMatches(Status.passport);
  if (matches.length > 0) {
    return int.parse(matches.elementAt(0).group(1));
  }
  return 42;
}

String extract_height_string() {
  RegExp exp = new RegExp(r"(?:^|.* )hgt:([0-9]+(in|cm))(?: |$)");
  Iterable<Match> matches = exp.allMatches(Status.passport);
  if (matches.length > 0) {
    return matches.elementAt(0).group(1);
  }
  return 'bogus';
}

bool height_valid() {
  var either_type_height = extract_height_string();
  if (either_type_height.contains('cm')) {
    var value = int.parse(
        either_type_height.substring(0, either_type_height.indexOf('cm')));
    if ((value >= 150) && (value <= 193)) {
      return true;
    }
  } else if (either_type_height.contains('in')) {
    var value = int.parse(
        either_type_height.substring(0, either_type_height.indexOf('in')));
    if ((value >= 59) && (value <= 76)) {
      return true;
    }
  }
  return false;
}

bool hair_color_valid() {
  RegExp exp = new RegExp(r"(?:^|.* )hcl:#([0-9a-f]+)(?: |$)");
  Iterable<Match> matches = exp.allMatches(Status.passport);
  if ((matches.length > 0) && (matches.elementAt(0).group(1).length == 6)) {
    return true;
  }
  return false;
}

bool eye_color_valid() {
  RegExp exp = new RegExp(r"(?:^|.* )ecl:([a-z]+)(?: |$)");
  Iterable<Match> matches = exp.allMatches(Status.passport);
  if (matches.length > 0) {
    return 'amb blu brn gry grn hzl oth'
        .contains(matches.elementAt(0).group(1));
  }
  return false;
}

bool pid_valid() {
  RegExp exp = new RegExp(r"(?:^|.* )pid:([0-9]{9})(?: |$)");
  Iterable<Match> matches = exp.allMatches(Status.passport);
  if (matches.length > 0) {
    return true;
  }
  return false;
}

bool data_validation() {
  var byr = extract_string_four_digit('byr');
  var iyr = extract_string_four_digit('iyr');
  var eyr = extract_string_four_digit('eyr');

  if ((byr >= 1920) &&
      (byr <= 2002) &&
      (iyr >= 2010) &&
      (iyr <= 2020) &&
      (eyr >= 2020) &&
      (eyr <= 2030) &&
      height_valid() &&
      hair_color_valid() &&
      eye_color_valid() &&
      pid_valid()) {
    return true;
  }
  return false;
  //indexOf('string',start)
}

void check_passport() {
  if ((Status.passport.contains('byr')) &&
      (Status.passport.contains('iyr')) &&
      (Status.passport.contains('eyr')) &&
      (Status.passport.contains('hgt')) &&
      (Status.passport.contains('hcl')) &&
      (Status.passport.contains('ecl')) &&
      (Status.passport.contains('pid'))) {
    if (data_validation()) {
      print(Status.passport);
      Status.valid_count += 1;
    }
  }
}

void handle_last() {
  check_passport();
  // print count....
  print('Answer ${Status.valid_count}');
}

void valid(line) {
  if (line == '') {
    //print(Status.passport);
    // check if valid, and increment count if so, and regardless clear string
    check_passport();
    Status.passport = '';
  } else {
    Status.passport += ' $line';
  }
}

void main() async {
  print('passports');
  var file = File('data.txt');
  Status.valid_count = 0;
  Status.passport = '';

  if (await file.exists()) {
    var contentStream = file.openRead();
    contentStream.transform(Utf8Decoder()).transform(LineSplitter()).listen(
        (String line) => valid(line),
        onDone: () => handle_last(),
        onError: (e) => print('$e'));
  }
}
