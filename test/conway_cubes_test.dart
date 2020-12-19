import 'package:flutter_test/flutter_test.dart';
import 'package:passport_app/day17/conway_cubes.dart';

void main() {
  setUp(() {});

  test('sample', () {
    readLine('.#.');
    readLine('..#');
    readLine('####');
    expect(answer(), 112);
  });
}
