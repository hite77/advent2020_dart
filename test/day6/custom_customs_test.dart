import 'package:flutter_test/flutter_test.dart';
import 'package:passport_app/day6/custom_customs.dart';

void main() {
  test("count works", () {
    Status.countOfQuestions = 0;
    Status.questions = 'aaabbc';
    countUp();
    expect(Status.countOfQuestions, 3);
  });

  test("concat works", () {
    Status.questions = '';
    Status.countOfQuestions = 0;
    Status.countOfAllYes = 0;
    Status.countOfQuestions = 0;
    Status.firstLine = true;
    sum('abc');
    sum('');
    print(Status.countOfQuestions);
    print(Status.countOfAllYes);
    sum('a');
    sum('b');
    sum('c');
    sum('');
    print(Status.countOfQuestions);
    print(Status.countOfAllYes);
    sum('ab');
    sum('ac');
    sum('');
    print(Status.countOfQuestions);
    print(Status.countOfAllYes);
    sum('a');
    sum('a');
    sum('a');
    sum('a');
    sum('');
    sum('b');
    print(Status.countOfQuestions);
    print(Status.countOfAllYes);
    countUp();
    print(Status.countOfQuestions);
    print(Status.countOfAllYes);

    expect(Status.countOfQuestions, 11);
    expect(Status.countOfAllYes, 6);
  });
}
