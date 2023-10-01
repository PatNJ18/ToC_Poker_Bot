import 'dart:math';

List<String> Dok = ["D", "S", "H", "C"];

List<String> Num = [
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "10",
  "J",
  "Q",
  "K",
  "A"
];

int cardCheck(List<String> cards) {
  // เริ่มต้นด้วยการนับค่าของแต่ละค่า (Num) และแต่ละสัญลักษณ์ (Dok)
  Map<String, int> numCount = {};
  Map<String, int> dokCount = {};

  for (String card in cards) {
    String num = card.substring(1);
    numCount[num] = (numCount[num] ?? 0) + 1;

    String dok = card.substring(0, 1);
    dokCount[dok] = (dokCount[dok] ?? 0) + 1;
  }

  // ตรวจสอบเงื่อนไขการชนะ
  bool isRoyalFlush = false;
  bool isStraightFlush = false;
  bool isFourOfAKind = false;
  bool isFullHouse = false;
  bool isFlush = false;
  bool isStraight = false;
  bool isThreeOfAKind = false;
  bool isTwoPair = false;
  bool isOnePair = false;

  // เรียงไพ่
  List<String> sortedCards = [...cards];
  sortedCards.sort(
      (a, b) => Num.indexOf(a.substring(1)) - Num.indexOf(b.substring(1)));

  // ตรวจสอบ Royal Flush
  if (numCount.containsKey("10") &&
      numCount.containsKey("J") &&
      numCount.containsKey("Q") &&
      numCount.containsKey("K") &&
      numCount.containsKey("A") &&
      dokCount.containsValue(5)) {
    isRoyalFlush = true;
  }

// ตรวจสอบ Straight Flush
  isStraightFlush = false;
  for (int i = 0; i < sortedCards.length - 4; i++) {
    String currentDok = sortedCards[i].substring(0, 1);
    int startIndex = Num.indexOf(sortedCards[i].substring(1));
    bool isConsecutive = true;
    for (int j = 0; j < 4; j++) {
      int nextIndex = Num.indexOf(sortedCards[i + j + 1].substring(1));
      String nextDok = sortedCards[i + j + 1].substring(0, 1);
      if (nextIndex != startIndex + j + 1 || currentDok != nextDok) {
        isConsecutive = false;
        break;
      }
    }
    if (isConsecutive) {
      isStraightFlush = true;
      break;
    }
  }

  // ตรวจสอบ Four of a Kind
  for (String num in numCount.keys) {
    if (numCount[num] == 4) {
      isFourOfAKind = true;
      break;
    }
  }

  // ตรวจสอบ Full House
  bool hasThreeOfAKind = false;
  bool hasPair = false;
  for (String num in numCount.keys) {
    if (numCount[num] == 3) {
      hasThreeOfAKind = true;
    } else if (numCount[num] == 2) {
      hasPair = true;
    }
  }
  if (hasThreeOfAKind && hasPair) {
    isFullHouse = true;
  }

// ตรวจสอบ Flush
  if (dokCount.containsValue(5)) {
    isFlush = true;
  }

  // ตรวจสอบ Straight
  isStraight = false;
  for (int i = 0; i < sortedCards.length - 4; i++) {
    int startIndex = Num.indexOf(sortedCards[i].substring(1));
    bool isConsecutive = true;
    for (int j = 0; j < 4; j++) {
      int nextIndex = Num.indexOf(sortedCards[i + j + 1].substring(1));
      if (nextIndex != startIndex + j + 1) {
        isConsecutive = false;
        break;
      }
    }
    if (isConsecutive) {
      isStraight = true;
      break;
    }
  }

  // ตรวจสอบ Three of a Kind
  for (String num in numCount.keys) {
    if (numCount[num] == 3) {
      isThreeOfAKind = true;
      break;
    }
  }

  // ตรวจสอบ Two Pair
  int pairCount = 0;
  for (String num in numCount.keys) {
    if (numCount[num] == 2) {
      pairCount++;
    }
  }
  if (pairCount >= 2) {
    isTwoPair = true;
  }

  // ตรวจสอบ One Pair
  if (pairCount == 1) {
    isOnePair = true;
  }

  // แสดงผลลัพธ์
  if (isRoyalFlush) {
    return (1);
  } else if (isStraightFlush) {
    return (2);
  } else if (isFourOfAKind) {
    return (3);
  } else if (isFullHouse) {
    return (4);
  } else if (isFlush) {
    return (5);
  } else if (isStraight) {
    return (6);
  } else if (isThreeOfAKind) {
    return (7);
  } else if (isTwoPair) {
    return (8);
  } else if (isOnePair) {
    return (9);
  } else {
    return (10);
  }
}

void main() {}
