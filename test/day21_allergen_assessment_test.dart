import 'package:flutter_test/flutter_test.dart';
import 'package:passport_app/day21/allergen_assessment.dart';

void main() {
  setUp(() {
    allText = [];
    allergens = new Map();
    conversion = new Map();
    repeatedWords = [];
  });

  test('build all text', () {
    parseLine('mxmxvkd kfcds sqjhc nhms (contains dairy, fish)');
    expect(allText[0], 'mxmxvkd kfcds sqjhc nhms');
  });

  test('count of all text works', () {
    parseLine('trh fvjkl sbzzf mxmxvkd foo bar (contains dairy)');
    expect(count(), 6);
  });

  test('removing a list of words works', () {
    parseLine('mxmxvkd kfcds sqjhc nhms (contains dairy, fish)');
    parseLine('trh fvjkl sbzzf mxmxvkd foo bar (contains dairy)');
    removeText('mxmxvkd');
    expect(count(), 8);
  });

  test('removing from start and another in a row works', () {
    parseLine('mxmxvkd mxmxvkd sqjhc nhms (contains dairy, fish)');
    removeText('mxmxvkd');
    expect(count(), 2);
  });

  test('parseLine collects possible ingredients into maps', () {
    parseLine('sqjhc mxmxvkd sbzzf (contains fish)');
    Map<String, List<String>> expectedMap = new Map();
    expectedMap['fish'] = ['sqjhc', 'mxmxvkd', 'sbzzf'];
    expect(allergens, expectedMap);
  });

  test('parseLine collects ingredients to multiple maps', () {
    parseLine('sqjhc mxmxvkd sbzzf (contains fish, honey)');
    Map<String, List<String>> expectedMap = new Map();
    expectedMap['fish'] = ['sqjhc', 'mxmxvkd', 'sbzzf'];
    expectedMap['honey'] = ['sqjhc', 'mxmxvkd', 'sbzzf'];
    expect(allergens, expectedMap);
  });

  test('parseLine starts finding allergen words and removing them', () {
    parseLine('sqjhc mxmxvkd sbzzf (contains fish, honey)');
    parseLine('sqjhc foo bar (contains honey)');
    Map<String, List<String>> expectedMap = new Map();
    expect(repeatedWords, ['sqjhc']);
    expect(allergens['honey'], []);
    expect(allergens['fish'], ['mxmxvkd', 'sbzzf']);
    expect(answer(), 4);
  });

  test('integration of answer', () {
    // kfcds, nhms, sbzzf, or trh no allergen's sbzzf twice
    parseLine('mxmxvkd kfcds sqjhc nhms (contains dairy, fish)');
    parseLine('trh fvjkl sbzzf mxmxvkd (contains dairy)');
    parseLine('sqjhc fvjkl (contains soy)');
    parseLine('sqjhc mxmxvkd sbzzf (contains fish)');
    expect(answer(), 5);
  });

  test('builds allergen to letters', () {
    parseLine('mxmxvkd kfcds sqjhc nhms (contains dairy, fish)');
    parseLine('trh fvjkl sbzzf mxmxvkd (contains dairy)');
    parseLine('sqjhc fvjkl (contains soy)');
    parseLine('sqjhc mxmxvkd sbzzf (contains fish)');
    expect(conversion['dairy'], 'mxmxvkd');
    expect(conversion['fish'], 'sqjhc');
    expect(conversion['soy'], 'fvjkl');
  });

  test('integration of answer2', () {
    // kfcds, nhms, sbzzf, or trh no allergen's sbzzf twice
    parseLine('mxmxvkd kfcds sqjhc nhms (contains dairy, fish)');
    parseLine('trh fvjkl sbzzf mxmxvkd (contains dairy)');
    parseLine('sqjhc fvjkl (contains soy)');
    parseLine('sqjhc mxmxvkd sbzzf (contains fish)');
    expect(answer2(), ['mxmxvkd', 'sqjhc', 'fvjkl']);
  });

  //Answer1 is 2020....
  //Answer2 is bcdgf, xhrdsl, vndrb, dhbxtb, lbnmsr, scxxn, bvcrrfbr, xcgtv
  // bcdgf,xhrdsl,vndrb,dhbxtb,lbnmsr,scxxn,bvcrrfbr,xcgtv
}
