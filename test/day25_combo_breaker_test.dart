import 'dart:core';

import 'package:flutter_test/flutter_test.dart';

class Encryption {
  int getEncryptionKey(int public_key1, int public_key2) {
    int loopCount1 = getloopCount(public_key1);
    int loopCount2 = getloopCount(public_key2);
    int smallest = loopCount1;
    int key = public_key2;
    int value = 1;
    if (loopCount2 < smallest) {
      smallest = loopCount2;
      key = public_key1;
    }
    while (smallest > 0) {
      value = value * key;
      value = value.remainder(20201227);
      smallest -= 1;
    }
    return value;
  }

  int getloopCount(int key) {
    int subject_number = 7;
    int value = 1;
    int loop_count = 0;
    while (value != key) {
      value = value * subject_number;
      value = value.remainder(20201227);
      loop_count += 1;
    }
    return loop_count;
  }
}

Encryption encryption;

void main() {
  setUp(() {
    encryption = new Encryption();
  });

  //The handshake used by the card and the door involves an operation that
  // transforms a subject number. To transform a subject number, start
  // with the value 1. Then, a number of times called the loop size,
  // perform the following steps:
  //
  //     Set the value to itself multiplied by the subject number.
  //     Set the value to the remainder after dividing the value by
  //     20201227.
  //
  // The card always uses a specific, secret loop size when it transforms
  // a subject number. The door always uses a different, secret loop size.
  //
  // The cryptographic handshake works like this:
  //
  //     The card transforms the subject number of 7 according to the
  //     card's secret loop size. The result is called the card's public
  //     key.
  //     The door transforms the subject number of 7 according to the
  //     door's secret loop size. The result is called the door's public
  //     key.
  //     The card and door use the wireless RFID signal to transmit the
  //     two public keys (your puzzle input) to the other device. Now, the
  //     card has the door's public key, and the door has the card's
  //     public key. Because you can eavesdrop on the signal, you have
  //     both public keys, but neither device's loop size.
  //     The card transforms the subject number of the door's public key
  //     according to the card's loop size. The result is the encryption
  //     key.
  //     The door transforms the subject number of the card's public key
  //     according to the door's loop size. The result is the same
  //     encryption key as the card calculated.

  // If you can use the two public keys to determine each device's loop
  // size, you will have enough information to calculate the secret
  // encryption key that the card and door use to communicate; this would
  // let you send the unlock command directly to the door!
  //
  // For example, suppose you know that the card's public key is 5764801.
  // With a little trial and error, you can work out that the card's loop
  // size must be 8, because transforming the initial subject number of 7
  // with a loop size of 8 produces 5764801.
  //
  // Then, suppose you know that the door's public key is 17807724. By the
  // same process, you can determine that the door's loop size is 11,
  // because transforming the initial subject number of 7 with a loop size
  // of 11 produces 17807724.
  //
  // At this point, you can use either device's loop size with the other
  // device's public key to calculate the encryption key. Transforming the
  // subject number of 17807724 (the door's public key) with a loop size
  // of 8 (the card's loop size) produces the encryption key, 14897079.
  // (Transforming the subject number of 5764801 (the card's public key)
  // with a loop size of 11 (the door's loop size) produces the same
  // encryption key: 14897079.)
  //
  // What encryption key is the handshake trying to establish?

  // my input...
  // 9232416
  // 14144084

  // 5764801
  // 17807724
  test('calculate loop counts', () {
    expect(encryption.getloopCount(5764801), 8);
    expect(encryption.getloopCount(17807724), 11);
  });

  test('calculate the encryption', () {
    expect(encryption.getEncryptionKey(5764801, 17807724), 14897079);
  });

  test('calculate part 1', () {
    expect(encryption.getEncryptionKey(9232416, 14144084), 1478097);
  });
}
