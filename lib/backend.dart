import 'dart:math';

import 'package:flutter/material.dart';

class TextNotifier extends ChangeNotifier {
  List<String> stringArray = [
    "C4",
    "D2",
    "HA",
    "S4",
    "D3"
  ];
}

                                                                    class BotHand extends ChangeNotifier {
                                                                      List<String> stringArray = [
    "S4",
    "SA",
                                                                      ];
                                                                    }

                                                                    class PlayerHand extends ChangeNotifier {
                                                                      List<String> stringArray = [
                                                                        "D10",
                                                                        "S8",
                                                                      ];
                                                                    }

class StringArrayNotifier extends ValueNotifier<List<String>> {
  StringArrayNotifier(List<String> value) : super(value);

  void updateValue() {
    List<String> card_deck = [];
    value.add(card_deck.removeAt(new Random().nextInt(card_deck.length)));
    notifyListeners();
  }
}
