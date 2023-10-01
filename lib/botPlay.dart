// ignore: file_names
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:poker/poker.dart';
import 'package:poker_bot/checkCard.dart';

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
  var _currentState = 'Start';
  String get currentState => _currentState;
  var previousState = 'Start';
  var states = States();
  var threshold = 1.0 / 3;
  bool wait = true;
  var round = 0;
  var tempCommuCards = '';
  var tempBotH = '';
  var tempPlayH = '';
  final logger = Logger();

  static Map<int, String> winHand = {
    1: 'Royal Flush',
    2: 'Straight Flush',
    3: 'Four of a Kind',
    4: 'Full House',
    5: 'Flush',
    6: 'Straight',
    7: 'Three of a Kind',
    8: 'Two Pair',
    9: 'One Pair',
    10: 'High Card',
  };

  void changeState(double prob, int bPlay) {
    int i = 1;
    bool out = false;

    if ((_currentState == 'Start' || _currentState == 'A Raise') && wait) {
      previousState = _currentState;
      _currentState = states.listStates[_currentState]![bPlay];
      wait = false;
    }

    if (_currentState == 'Advance' && round == 3) {
      String winner = checkWin();

      if (winner == 'A Win') {
        _currentState = 'A Win';
        return;
      }

      if (winner == 'B Win') {
        _currentState = 'B Win';
        return;
      }

      _currentState = 'Draw';
      out = true;
    }

    while (!out & !wait) {
      if (threshold * i < prob &&
          i < states.listStates[_currentState]!.length) {
        i++;
      } else {
        out = true;
        if (states.listStates[_currentState]?[i - 1] != null && !(wait)) {
          previousState = _currentState;
          _currentState = states.listStates[_currentState]![i - 1];

          if (_currentState == 'A Raise' || _currentState == 'Start') {
            wait = true;
          } else {
            wait = false;
          }

          if (_currentState == 'Advance') {
            round++;
          }

          threshold = 1.0 / states.listStates[_currentState]!.length;
        }
      }
    }
  }

  // ignore: non_constant_identifier_names
  double monteEvaluate(String Bothand, String playerHand, String CommuCards) {
    if (tempBotH == '' && tempCommuCards == '' && tempPlayH == '') {
      tempBotH = Bothand;
      tempCommuCards = CommuCards;
      tempPlayH = playerHand;
    }
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

  String checkWin() {
    logger.d('Bothand : $tempBotH');
    logger.d('Community : $tempCommuCards');
    logger.d('Playhand : $tempPlayH');
    final evaluator = ExhaustiveEvaluator(
      communityCards: ImmutableCardSet.parse(tempCommuCards),
      players: [
        HandRange.parse(tempBotH),
        HandRange.parse(tempPlayH),
      ],
    );

    var wons = [0, 0];

    for (final matchup in evaluator) {
      for (final i in matchup.wonPlayerIndexes) {
        wons[i] += 1;
      }
    }

    logger.d('win array: $wons');
    if (wons[0] > wons[1]) {
      return 'A Win';
    } else if (wons[1] > wons[0]) {
      return 'B Win';
    } else {
      return 'Draw';
    }
  }
}

class States {
  var listStates = {
    'Start': ['B Fold', 'B Bet', 'B Check'],
    'B Fold': ['A Win'],
    'B Bet': ['A Fold', 'A Call', 'A Raise'],
    'B Check': ['A Fold', 'A Raise', 'A Check'],
    'B Call': ['Advance'],
    'A Fold': ['B Win'],
    'A Call': ['Advance'],
    'A Check': ['Advance'],
    'A Raise': ['B Fold', 'B Call'],
    'Advance': ['Start'],
    'B Win': ['B Win'],
    'A Win': ['A Win'],
    'Draw': ['Draw']
  };
}
