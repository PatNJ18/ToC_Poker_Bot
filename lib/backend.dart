import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'package:random_string_generator/random_string_generator.dart';

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

  void updateValue(List<String> newValue) {
    for (var i = 0; i < 5; i++) {
      final faker = Faker();
      var generator = RandomStringGenerator(
          hasAlpha: true,
          hasDigits: true,
          alphaCase: AlphaCase.UPPERCASE_ONLY,
          hasSymbols: false,
          minLength: 2,
          maxLength: 2,
          mustHaveAtLeastOneOfEach: false,
          customUpperAlphabet: [
            'D',
            'S',
            'H',
            'C'
          ],
          customDigits: [
            '1',
            '2',
            '3',
            '4',
            '5',
            '6',
            '7',
            '8',
            '9',
            'A',
            'K',
            'Q',
            'J'
          ]);

      newValue.add(generator.generate());
    }
    value = newValue;
    notifyListeners();
  }
}
