// ignore: file_names
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:poker/poker.dart';

class TextNotifier extends ChangeNotifier {}

void main() {
  var botTest = Botplay();
  print(botTest.monteEvaluate('S5', 'S5', 'S5'));
}

class Deck {
  List<String> deck = [
    'H2',
    'H3',
    'H4',
    'H5',
    'H6',
    'H7',
    'H8',
    'H9',
    'HT',
    'HJ',
    'HQ',
    'HK',
    'HA',
    'C2',
    'C3',
    'C4',
    'C5',
    'C6',
    'C7',
    'C8',
    'C9',
    'CT',
    'CJ',
    'CQ',
    'CK',
    'CA',
    'D2',
    'D3',
    'D4',
    'D5',
    'D6',
    'D7',
    'D8',
    'D9',
    'DT',
    'DJ',
    'DQ',
    'DK',
    'DA',
    'S2',
    'S3',
    'S4',
    'S5',
    'S6',
    'S7',
    'S8',
    'S9',
    'ST',
    'SJ',
    'SQ',
    'SK',
    'SA'
  ];

  String drawCard() {
    return deck.removeAt(Random().nextInt(this.deck.length));
  }
}

class StringArrayNotifier extends ValueNotifier<List<String>> {
  StringArrayNotifier(List<String> value) : super(value);
  Deck cards = new Deck();

  void updateValue(int num) {
    for (int i = 0; i < num; i++) {
      value.add(cards.drawCard());
    }
    notifyListeners();
  }

  List<String> drawNcard(int num) {
    List<String> hand = [];

    for (int i = 0; i < num; i++) {
      hand.add(cards.drawCard());
    }
    return hand;
  }
}

class Botplay {
  var currentState = 'Start';
  var states = States();
  var threshold = 1.0 / 3;
  bool wait = false;

  void changeState(double prob, int bPlay) {
    int i = 1;
    var path = states.list_states[currentState]?.length;
    print(currentState);

    if (currentState == 'A Calls' || currentState == 'A Raises') {
      currentState = states.list_states[currentState]![bPlay];
    }

    while (i <= path! && !wait) {
      if (threshold * i < prob) {
        i++;
        print(i);
      } else {
        if (states.list_states[currentState]?[i - 1] != null && !(wait)) {
          currentState = states.list_states[currentState]![i - 1];
          if (currentState == 'A Calls' || currentState == 'A Raises') {
            wait = true;
          } else {
            wait = false;
          }
          threshold = 1.0 / states.list_states[currentState]!.length;
        }
      }
    }
  }

  // ignore: non_constant_identifier_names
  double monteEvaluate(String Bothand, String playerHand, String CommuCards) {
    final evaluator = MontecarloEvaluator(
        communityCards: ImmutableCardSet.parse(CommuCards),
        players: [
          HandRange.parse(Bothand),
          HandRange.parse(playerHand),
        ]);

    var wons = [0, 0];

    for (final matchup in evaluator.take(100000)) {
      for (final i in matchup.wonPlayerIndexes) {
        wons[i] += 1;
      }
    }

    return wons[0] / 100000;
  }

  String cardPpare(List<String> hand) {
    String temp = '';
    for (int i = 0; i < hand.length; i++) {
      temp += hand[i][1] + hand[i][0].toLowerCase();
    }
    return temp;
  }
}

class States {
  var list_states = {
    'Start': ['A Folds', 'A Calls', 'A Raises'],
    'A Folds': ['Endhand'],
    'A Calls': ['B Checks', 'B Raises', 'B Folds'],
    'A Raises': ['B Folds', 'B Calls'],
    'B Checks': ['Advance'],
    'B Raises': ['2 A Folds', '2 A Calls', 'A Raises'],
    'B Folds': ['Endhand'],
    '2 A Folds': ['A Folds'],
    '2 A Calls': ['Advance'],
    'Endhand': ['None'],
    'Advance': ['None']
  };
}