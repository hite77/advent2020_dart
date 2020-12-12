import 'package:flutter_test/flutter_test.dart';
import 'package:passport_app/passport.dart';

void main() {
  test("hair color test works if valid string is at end", () {
    Status.passport = 'hcl:#000000';
    expect(hair_color_valid(), true);
    Status.passport = 'hcl:#123abc';
    expect(hair_color_valid(), true);
    Status.passport = 'hcl:#123abz';
    expect(hair_color_valid(), false);
    Status.passport = 'hcl:123abc';
    expect(hair_color_valid(), false);
    Status.passport = 'hcl:#123abcZ';
    expect(hair_color_valid(), false);
    Status.passport = 'hcl:#123abc Zoo';
    expect(hair_color_valid(), true);
  });

  test("eye color test", () {
    Status.passport = 'ecl:amb';
    expect(eye_color_valid(), true);
    Status.passport = 'some ecl:blu';
    expect(eye_color_valid(), true);
    Status.passport = 'yecl:brn';
    expect(eye_color_valid(), false);
    Status.passport = 'ecl:wat';
    expect(eye_color_valid(), false);
    Status.passport = 'ecl:grnY';
    expect(eye_color_valid(), false);
    Status.passport = 'ecl:hzl Zoo';
    expect(eye_color_valid(), true);
  });

  test("pid test", () {
    Status.passport = 'pid:000000001';
    expect(pid_valid(), true);
    Status.passport = 'some pid:087499704';
    expect(pid_valid(), true);
    Status.passport = 'epid:896056539';
    expect(pid_valid(), false);
    Status.passport = 'pid:186cm';
    expect(pid_valid(), false);
    Status.passport = 'pid:0123456789';
    expect(pid_valid(), false);
    Status.passport = 'pid:3556412378';
    expect(pid_valid(), false);

    Status.passport = 'pid:545766238V';
    expect(pid_valid(), false);
    Status.passport = 'pid:093154719 whale';
    expect(pid_valid(), true);
    Status.passport = 'another pid:012533040 fox';
    expect(pid_valid(), true);
    Status.passport = 'a pid:021572410 42';
    expect(pid_valid(), true);
  });

  test("extract four digit", () {
    Status.passport = 'fwr:1023';
    expect(extract_string_four_digit('fwr'), 1023);
    Status.passport = 'fwr:1023';
    expect(extract_string_four_digit('not_there'), 42);
    Status.passport = 'fwr:10234';
    expect(extract_string_four_digit('fwr'), 42);
  });

  test("extract height string", () {
    Status.passport = 'hgt:1023in';
    expect(extract_height_string(), '1023in');
    Status.passport = 'hgt:1023tm';
    expect(extract_height_string(), 'bogus');
    Status.passport = 'hgt:10233232cm';
    expect(extract_height_string(), '10233232cm');
    Status.passport = 'hgt:1023cmr';
    expect(extract_height_string(), 'bogus');
  });
}
