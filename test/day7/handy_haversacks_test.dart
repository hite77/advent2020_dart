import 'package:flutter_test/flutter_test.dart';
import 'package:passport_app/day7/handy_haversacks.dart';

void main() {
  test("parse color on left side", () {
    expect(
        left_side(
            "light red bags contain 1 bright white bag, 2 muted yellow bags."),
        "light red");
  });

  test("right side test", () {
    expect(
        right_side(
            "dotted salmon bags contain 1 pale violet bag, 1 bright bronze bag, 5 striped purple bags, 5 mirrored crimson bags."),
        ["pale violet", "bright bronze", "striped purple", "mirrored crimson"]);
  });

  test("filter", () {
    expect(filter("dotted black bags contain no other bags."), true);
    expect(
        filter(
            "light red bags contain 1 bright white bag, 2 muted yellow bags."),
        false);
    expect(
        filter(
            "shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags."),
        true);
  });

  test("example", () {
    parse("light red bags contain 1 bright white bag, 2 muted yellow bags.");
    parse("dark orange bags contain 3 bright white bags, 4 muted yellow bags.");
    parse("bright white bags contain 1 shiny gold bag.");
    parse("muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.");
    parse("shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.");
    parse("dark olive bags contain 3 faded blue bags, 4 dotted black bags.");
    parse("vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.");
    parse("faded blue bags contain no other bags.");
    parse("dotted black bags contain no other bags.");
    expect(count(), 4);
  });

  test("example part 2", () {
    parse_number(
        "light red bags contain 1 bright white bag, 2 muted yellow bags.");
    parse_number(
        "dark orange bags contain 3 bright white bags, 4 muted yellow bags.");
    parse_number("bright white bags contain 1 shiny gold bag.");
    parse_number(
        "muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.");
    parse_number(
        "shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.");
    parse_number(
        "dark olive bags contain 3 faded blue bags, 4 dotted black bags.");
    parse_number(
        "vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.");
    parse_number("faded blue bags contain no other bags.");
    parse_number("dotted black bags contain no other bags.");
    expect(count_number(), 32);
  });

  int something(number) {
    if (number == 0) {
      return 0;
    }
    return number + something(number - 1);
  }

  test("recursive", () {
    expect(something(5), 5 + 4 + 3 + 2 + 1);
  });
}
