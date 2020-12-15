import 'package:flutter_test/flutter_test.dart';
import 'package:passport_app/day15/rambunctious_recitation.dart';

void main() {
  setUp(() {});

  test('all samples', () {
    expect(loadAndCalculate([0, 3, 6]), 436);
    expect(loadAndCalculate([1, 3, 2]), 1);
    expect(loadAndCalculate([2, 1, 3]), 10);
    expect(loadAndCalculate([1, 2, 3]), 27);
    expect(loadAndCalculate([2, 3, 1]), 78);
    expect(loadAndCalculate([3, 2, 1]), 438);
    expect(loadAndCalculate([3, 1, 2]), 1836);
  });

  test('part2 samples', () {
    expect(loadAndCalculate([0, 3, 6], lastElement: 30000000), 175594);
    expect(loadAndCalculate([1, 3, 2], lastElement: 30000000), 2578);
    expect(loadAndCalculate([2, 1, 3], lastElement: 30000000), 3544142);
    expect(loadAndCalculate([1, 2, 3], lastElement: 30000000), 261214);
    expect(loadAndCalculate([2, 3, 1], lastElement: 30000000), 6895259);
    expect(loadAndCalculate([3, 2, 1], lastElement: 30000000), 18);
    expect(loadAndCalculate([3, 1, 2], lastElement: 30000000), 362);
  });
}
