import 'dart:convert';
import 'dart:core';
import 'dart:io';

// first is earliest time stamp....
// id number and how often it leaves
// minutes since referencd time
// 0 they all left...
// id 5 left at 0, 5, 10, 15....
// id 11 left at 0, 11, 22, 33....
// ignore x's.....

int timestamp;
List<int> busIds = [];
List<int> part2Ids = [];

readLine(String line) {
  if (!line.contains('x') && !line.contains(',')) {
    timestamp = int.parse(line);
  } else if (line.contains(',')) {
    busIds = [];
    part2Ids = [];
    line.split(',').forEach((element) {
      if (element != 'x') {
        busIds.add(int.parse(element));
        part2Ids.add(int.parse(element));
      } else {
        part2Ids.add(-1);
      }
    });
  }
  print('timestamp: $timestamp');
  print('busIds: $busIds');
  print('part2Ids: $part2Ids');
}

int differenceForBus(id) {
  return ((timestamp / id).floor() + 1) * id - timestamp;
}

int computeLeftover(int t, int modulus) {
  if (t == 0) {
    return 0;
  }
  var tryValue = 0;
  while ((tryValue + t) % modulus != 0) {
    tryValue += 1;
  }
  return tryValue;
}

int calculateU(int partModulus, int modulus) {
  // 323u2 = 1 (mod 13) ==> u2 == 6
  var tryValue = 0;
  while ((partModulus * tryValue) % modulus != 1) {
    tryValue += 1;
  }
  return tryValue;
}

int subtractModulus(sum, modulus) {
  while (sum > modulus) {
    sum -= modulus;
  }
  return sum;
}

int part2Answer() {
  // need to get the modulus equations..... part2Ids is either number, or -1 for x
  List<int> modulus = [];
  List<int> leftover = [];
  List<int> u = [];
  List<int> partModulus = [];
  int productModulus = 0;
  //t is position.....
  for (int t = 0; t < part2Ids.length; t++) {
    if (part2Ids[t] != -1) {
      modulus.add(part2Ids[t]);
      leftover.add(computeLeftover(t, part2Ids[t]));
    }
  }

  productModulus = modulus[0];
  for (int i = 1; i < modulus.length; i++) {
    productModulus *= modulus[i];
  }
  for (int i = 0; i < modulus.length; i++) {
    partModulus.add((productModulus / modulus[i]).floor());
  }
  for (int i = 0; i < modulus.length; i++) {
    u.add(calculateU(partModulus[i], modulus[i]));
  }

  // solving the chinese remainder....

  // X =0 (mod 17)
  // X=2  (mod 13)
  // X=3  (mod 19)
  //
  //
  // Ni    ai.
  //
  // 17.    0.     247.         247u1 = 1 (mod 17) ==> doesn’t matter…
  // 13.    2.     323.         323u2 = 1 (mod 13) ==> u2 == 6
  // 19     3.     221.           221u3 = 1 (mod 19) ==> u3== 8
  //
  // X = (2)(323)(6).          +(3)(221)(8)

  var rawsum = 0;
  for (int i = 0; i < modulus.length; i++) {
    rawsum = rawsum + (leftover[i] * partModulus[i] * u[i]);
  }
  // need to keep subtracting modulus from it, till smaller than modulus
  rawsum = subtractModulus(rawsum, productModulus);
  return rawsum;
}

int answer() {
  var idOfLowestMinutesWait = busIds[0];
  var lowestMinutesWait = differenceForBus(idOfLowestMinutesWait);

  // go through each, multiple id until > timestamp calculate difference
  busIds.forEach((id) {
    if (differenceForBus(id) < lowestMinutesWait) {
      idOfLowestMinutesWait = id;
      lowestMinutesWait = differenceForBus(id);
    }
  });

  return idOfLowestMinutesWait * lowestMinutesWait;
}

void main() async {
  print('shuttle search');
  var file = File('data.txt');
  if (await file.exists()) {
    var contentStream = file.openRead();
    contentStream.transform(Utf8Decoder()).transform(LineSplitter()).listen(
        (String line) => readLine(line),
        onDone: () => print('Answer:${answer()} part2Answer: ${part2Answer()}'),
        onError: (e) => print('$e'));
  }
}
