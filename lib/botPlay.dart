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
  var previousState = 'Start';
  var states = States();
  var threshold = 1.0 / 3;
  bool wait = false;
  var round = 0;

  void changeState(double prob, int bPlay) {
    int i = 1;
    bool out = false;

    if (currentState == 'Start' && wait) {
      previousState = currentState;
      currentState = states.ListStates[currentState]![bPlay];
    }

    if (currentState == 'Advance' && round == 3) {
      // TODO : Decision winner Function Call
    }

    while (!out & !wait) {
      if (threshold * i < prob) {
        i++;
      } else {
        out = true;
        if (states.ListStates[currentState]?[i - 1] != null && !(wait)) {
          previousState = currentState;
          currentState = states.ListStates[currentState]![i - 1];

          if (currentState == 'A Raise' || currentState == 'Start') {
            wait = true;
          } else {
            wait = false;
          }

          if (currentState == 'Advance') {
            round++;

            // TODO : Gameplay Select Round 1 : Open 3 community Card Round 2 : Draw Card Round 3 : Draw Card an finish game
          }

          threshold = 1.0 / states.ListStates[currentState]!.length;
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
  var ListStates = {
    'Start': ['B Fold', 'B Bet', 'B Check'],
    'B Fold': ['A Win'],
    'B Bet': ['A Fold', 'A Call', 'A Raise'],
    'B Check': ['A Fold', 'A Raise', 'A Check'],
    'B Call': ['Advance'],
    'A Fold': ['B Win'],
    'A Call': ['Advance'],
    'A Check': ['Advance'],
    'A Raise': ['B Fold', 'B Call'],
    'Advance': ['Start', 'A Win', 'B Win']
  };
}
