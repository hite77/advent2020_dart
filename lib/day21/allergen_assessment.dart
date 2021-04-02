import 'dart:convert';
import 'dart:core';
import 'dart:io';

Map<String, List<String>> allergens = new Map();
List<String> allText = [];
List<String> repeatedWords = [];
Map<String, String> conversion = new Map();

void parseLine(String text) {
  String extract_ingredients = text.substring(0, text.indexOf(' (contains'));
  allText.add(extract_ingredients);
  String extract_contains =
      text.substring(text.indexOf('contains '), text.indexOf(')'));
  extract_contains = extract_contains.replaceAll('contains ', '');
  extract_contains.split(',').forEach((allergen) {
    // if allergens already exists remove words that are not duplicated.
    // otherwise do this to write the words in.
    // if removing words they need to disappear from other ingredients list
    // and be added to a list of words to be removed as each line is parsed.
    if (allergens[allergen.trim()] != null) {
      // remove words that are not duplicates

      // if 1 word left, add that to repeatedWords.... and remove the repeatedWords
      List<String> duplicates = [];
      extract_ingredients.split(' ').forEach((element) {
        if (allergens[allergen.trim()].contains(element)) {
          duplicates.add(element);
        }
      });
      allergens[allergen.trim()] = duplicates;
      if (duplicates.length == 1) {
        repeatedWords.add(duplicates.first);
        List<String> addWords = removeText(duplicates.first);
        addWords.forEach((element) {
          repeatedWords.add(element);
        });
        conversion[allergen.trim()] = duplicates.first;
        allergens[allergen.trim()] =
            []; // later on may want to build a map of allergen to string
      }
    } else {
      allergens[allergen.trim()] = extract_ingredients.split(' ');
    }
  });
  // remove repeatedWords from all text.....

  List<String> addWords = [];

  do {
    addWords = [];
    repeatedWords.forEach((element) {
      List<String> addedWords = removeText(element);
      addedWords.forEach((element) {
        addWords.add(element);
      });
    });
    addWords.forEach((element) {
      repeatedWords.add(element);
    });
  } while (addWords.isNotEmpty);
}

void removeFromAllText(String text) {
  List<String> replacedText = [];
  allText.forEach((line) {
    String newline = line.replaceAll(' ' + text, '');
    newline = newline.replaceAll(text + ' ', '');
    if (newline != text) {
      replacedText.add(newline);
    }
  });
  allText = replacedText;
}

List<String> removeText(String text) {
  // kfcds, nhms, sbzzf, or trh no allergen's sbzzf twice
  removeFromAllText(text);

  List<String> addWords = [];

  allergens.keys.forEach((key) {
    List<String> text_removed = [];
    allergens[key].forEach((ingredient) {
      text.split(' ').forEach((textElement) {
        if (ingredient != textElement) {
          text_removed.add(ingredient);
        }
      });
    });
    allergens[key] = text_removed;
    if (text_removed.length == 1) {
      conversion[key] = text_removed.first;
      allergens[key] = [];
      text_removed.forEach((element) {
        addWords.add(element);
      });
    }
  });
  return addWords;
}

int count() {
  int countWords = 0;
  allText.forEach((element) {
    countWords = countWords + (element.split(' ').length);
  });
  return countWords;
}

List<String> answer2() {
  print('Answer2');
  List<String> sortedKeys = [];
  List<String> answer = [];
  conversion.keys.forEach((element) {
    sortedKeys.add(element);
  });
  sortedKeys.sort();
  sortedKeys.forEach((element) {
    answer.add(conversion[element]);
  });
  return answer;
}

int answer() {
  print('Answer');
  // print('AllText');
  // print(allText);
  // print('repeatedWords');
  // print(repeatedWords);
  // print('allergens');
  // print(allergens);
  return count();
}

void main() async {
  var file = File('data.txt');
  if (await file.exists()) {
    var contentStream = file.openRead();
    contentStream.transform(Utf8Decoder()).transform(LineSplitter()).listen(
        (String line) => parseLine(line),
        onDone: () =>
            print('part1Answer: ${answer()}, part2Answer: ${answer2()}'),
        onError: (e) => print('$e'));
  }
}
