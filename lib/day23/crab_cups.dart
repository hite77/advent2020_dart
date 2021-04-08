import 'dart:core';

List<int> items = [];
List<int> holdThree = [];
int current_cup;

String answer(String s) {
  return move(s, 100);
}

String answer2(String s) {
  return move2(s, 10000000);
}

String move2(String s, int loops) {
  items = [];
  for (var i = 0; i < s.length; i++) {
    if (i < s.length - 1) {
      items.add(int.parse(s.substring(i, i + 1)));
    } else {
      items.add(int.parse(s.substring(i)));
    }
  }
  int highest = items[0];
  items.forEach((element) {
    if (element > highest) {
      highest = element;
    }
  });

  while (highest < 1000000) {
    highest += 1;
    items.add(highest);
  }

  current_cup = items[0];

  while (loops > 0) {
    moveThreeCups(items, holdThree, current_cup);
    var destination = updateDestination2(items, current_cup);
    print('Hold: $holdThree Destination: $destination');
    placeTheCups(items, destination, holdThree);
    current_cup = clockwiseSelectCup(items, current_cup);
    print('Current cup: $current_cup');
    loops--;
    print('$loops ${output2(items)} ${items.indexOf(1)}');
  }
  return output2(items);
}

String output2(List<int> items) {
  String twoValues = '';
  int values = 0;
  int position_of_1 = items.indexOf(1);
  if (position_of_1 < items.length - 1) {
    for (var i = position_of_1 + 1; i < items.length; i++) {
      twoValues += ' ${items[i]} ';
      values += 1;
      if (values == 2) {
        return twoValues;
      }
    }
  }
  if (position_of_1 > 0) {
    for (var i = 0; i < position_of_1; i++) {
      twoValues += ' ${items[i]} ';
      values += 1;
      if (values == 2) {
        return twoValues;
      }
    }
  }
}

String output(List<int> items) {
  String output = '';
  int position_of_1 = items.indexOf(1);
  if (position_of_1 < items.length - 1) {
    for (var i = position_of_1 + 1; i < items.length; i++) {
      output += '${items[i]}';
    }
  }
  if (position_of_1 > 0) {
    for (var i = 0; i < position_of_1; i++) {
      output += '${items[i]}';
    }
  }
  return output;
}

moveThreeCups(List<int> items, List<int> holdThree, current_cup) {
  // The crab picks up the three cups that are immediately clockwise of
  // the current cup. They are removed from the circle; cup spacing is
  // adjusted as necessary to maintain the circle.
  // first case current cup has three directly next to it...
  int position_current_cup = items.indexOf(current_cup);

  if (items.length - 1 - position_current_cup >= 3) {
    holdThree.add(items[position_current_cup + 1]);
    holdThree.add(items[position_current_cup + 2]);
    holdThree.add(items[position_current_cup + 3]);
    holdThree.forEach((element) {
      items.remove(element);
    });
  } else {
    // one, two possible....
    for (var i = position_current_cup + 1; i < items.length; i++) {
      holdThree.add(items[i]);
    }
    int leftOver = 3 - holdThree.length;
    for (var i = 0; i < leftOver; i++) {
      holdThree.add(items[i]);
    }
    holdThree.forEach((element) {
      items.remove(element);
    });
  }
  // otherwise it needs to wrap around...
}

updateDestination2(List<int> items, current_cup) {
  // The crab selects a destination cup: the cup with a label equal to
  // the current cup's label minus one. If this would select one of the
  // cups that was just picked up, the crab will keep subtracting one
  // until it finds a cup that wasn't just picked up. If at any point in
  // this process the value goes below the lowest value on any cup's
  // label, it wraps around to the highest value on any cup's label
  // instead.
  int try_cup = current_cup - 1;
  while (!items.contains(try_cup)) {
    if (try_cup < 1) {
      try_cup = 1000000;
    } else {
      try_cup -= 1;
    }
  }

  return try_cup;
}

updateDestination(List<int> items, current_cup) {
  // The crab selects a destination cup: the cup with a label equal to
  // the current cup's label minus one. If this would select one of the
  // cups that was just picked up, the crab will keep subtracting one
  // until it finds a cup that wasn't just picked up. If at any point in
  // this process the value goes below the lowest value on any cup's
  // label, it wraps around to the highest value on any cup's label
  // instead.
  int try_cup = current_cup - 1;
  while (!items.contains(try_cup)) {
    if (try_cup < 1) {
      try_cup = 9;
    } else {
      try_cup -= 1;
    }
  }

  return try_cup;
}

placeTheCups(List<int> items, int current_cup, List<int> holdThree) {
  // The crab places the cups it just picked up so that they are
  // immediately clockwise of the destination cup. They keep the same
  // order as when they were picked up.
  int position_current_cup = items.indexOf(current_cup);
  items.insertAll(position_current_cup + 1, holdThree);
  holdThree.clear();
}

clockwiseSelectCup(List<int> items, int current_cup) {
  // The crab selects a new current cup: the cup which is immediately
  // clockwise of the current cup.
  int position_current_cup = items.indexOf(current_cup) + 1;

  if (position_current_cup >= items.length) {
    position_current_cup = 0;
  }
  return items[position_current_cup];
}

String move(String s, int loops) {
  items = [];
  for (var i = 0; i < s.length; i++) {
    if (i < s.length - 1) {
      items.add(int.parse(s.substring(i, i + 1)));
    } else {
      items.add(int.parse(s.substring(i)));
    }
  }
  current_cup = items[0];

  while (loops > 0) {
    moveThreeCups(items, holdThree, current_cup);
    var destination = updateDestination(items, current_cup);
    placeTheCups(items, destination, holdThree);
    current_cup = clockwiseSelectCup(items, current_cup);
    loops--;
  }

  print(items);

  return output(items);
}

void main() {
  String puzzleInput = '496138527';

  print('Answer: ${answer(puzzleInput)}');
  print('Answer2: ${answer2(puzzleInput)}');
}
