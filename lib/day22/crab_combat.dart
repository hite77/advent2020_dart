import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:collection/collection.dart';

List<int> player1 = [];
List<int> player2 = [];
List<int> player1Recursive = [];
List<int> player2Recursive = [];

bool player1Current = true;

void readLine(String line) {
  if ((line == 'Player 1:') || (line == '')) {
    //nothing
  } else if (line == 'Player 2:') {
    player1Current = false;
  } else {
    int add = int.parse(line);
    if (player1Current) {
      player1.add(add);
      player1Recursive.add(add);
    } else {
      player2.add(add);
      player2Recursive.add(add);
    }
  }
}

void play(List<int> player1, List<int> player2) {
  // give cards to winner....
  int player1Card = player1.first;
  print('Player 1 plays: $player1Card');
  int player2Card = player2.first;
  print('Player 2 plays: $player2Card');
  if (player1Card > player2Card) {
    print('Player 1 wins the round!');
    updateWin(1, player1, player2);
  } else {
    print('Player 2 wins the round!');
    updateWin(2, player1, player2);
  }
}

void updateWin(int winner, List<int> player1, List<int> player2) {
  int player1Card = player1.first;
  int player2Card = player2.first;
  player1.remove(player1Card);
  player2.remove(player2Card);
  if (winner == 1) {
    player1.add(player1Card);
    player1.add(player2Card);
  } else {
    player2.add(player2Card);
    player2.add(player1Card);
  }
}

bool playedBefore(
    List<int> deck1, List<int> deck2, player1Hands, player2Hands) {
  bool found1 = false;
  int foundInPlayer1 = -1;
  Function eq = const ListEquality().equals;
  player1Hands.forEach((element) {
    if (!found1) {
      foundInPlayer1 += 1;
      if (eq(element, deck1)) {
        found1 = true;
      }
    }
  });
  if (found1 && eq(player2Hands.elementAt(foundInPlayer1), deck2)) {
    return true;
  }
  return false;
}

bool enoughToRecurse(List<int> deck1, List<int> deck2) {
  return (((deck1.first + 1) <= deck1.length) &&
      ((deck2.first + 1) <= deck2.length));
}

List<int> sublist(List<int> deck) {
  return deck.sublist(1, deck.first + 1);
}

int recursivePlay(List<int> deck1, List<int> deck2) {
  List<List<int>> played1 = [];
  List<List<int>> played2 = [];

  while (!done(deck1, deck2)) {
    if (playedBefore(deck1, deck2, played1, played2)) {
      return 1;
    }
    played1.add(deck1.sublist(0));
    played2.add(deck2.sublist(0));
    if (enoughToRecurse(deck1, deck2)) {
      int winner = recursivePlay(sublist(deck1), sublist(deck2));
      print('winner:$winner length1:${deck1.length} length2:${deck2.length}');
      updateWin(winner, deck1, deck2);
    } else {
      if (deck1.first > deck2.first) {
        print('winner:1 deck1:$deck1 deck2:$deck2');
        updateWin(1, deck1, deck2);
      } else {
        print('winner:2 deck1:$deck1 deck2:$deck2');
        updateWin(2, deck1, deck2);
      }
    }
  }

  if (deck1.isEmpty) {
    return 2;
  } else {
    return 1;
  }
}

bool done(List<int> deck1, List<int> deck2) {
  return deck1.isEmpty || deck2.isEmpty;
}

int score(List<int> deck1, List<int> deck2) {
  List<int> result = [];
  if (deck1.isNotEmpty) {
    result = deck1;
  } else {
    result = deck2;
  }

  int total = 0;
  int position = 1;
  while (result.isNotEmpty) {
    total += result.last * position;
    position += 1;
    result.remove(result.last);
  }

  return total;
}

int answer() {
  int round = 1;

  while (!done(player1, player2)) {
    print('-- Round $round --');
    round += 1;
    print("Player 1's deck: $player1");
    print("Player 2's deck: $player2");
    play(player1, player2);
  }

  int score_total = score(player1, player2);
  print('Score: $score_total}');

  return score_total;
}

int answer2() {
  // tried it and got 34001 which it says is too high
  // 33134
  // 32115
  // tried 9043 which it said was too low....
  // 7291...
  // 8013
  // 30822  not right...
  // 34001 not right....
  // 9833
  // 32751 correct

  List<List<int>> played1 = [];
  List<List<int>> played2 = [];

  while (!done(player1Recursive, player2Recursive)) {
    if (playedBefore(player1Recursive, player2Recursive, played1, played2)) {
      updateWin(1, player1Recursive, player2Recursive);
    } else {
      played1.add(player1Recursive.sublist(0));
      played2.add(player2Recursive.sublist(0));
      if (enoughToRecurse(player1Recursive, player2Recursive)) {
        int winner =
            recursivePlay(sublist(player1Recursive), sublist(player2Recursive));
        print(
            'winner:$winner length1:${player1Recursive.length} length2:${player2Recursive.length}');
        // if (winner == 42) {
        //   return (score(player1Recursive, []));
        // }
        updateWin(winner, player1Recursive, player2Recursive);
      } else {
        if (player1Recursive.first > player2Recursive.first) {
          print(
              'winner:1 length1:${player1Recursive.length} length2:${player2Recursive.length}');
          updateWin(1, player1Recursive, player2Recursive);
        } else {
          print(
              'winner:2 length1:${player1Recursive.length} length2:${player2Recursive.length}');
          updateWin(2, player1Recursive, player2Recursive);
        }
      }
    }
  }

  return score(player1Recursive, player2Recursive);
}

void main() async {
  var file = File('data.txt');
  if (await file.exists()) {
    var contentStream = file.openRead();
    contentStream.transform(Utf8Decoder()).transform(LineSplitter()).listen(
        (String line) => readLine(line),
        onDone: () => print('Answer: ${answer()} Answer2: ${answer2()}'),
        onError: (e) => print('$e'));
  }
}
