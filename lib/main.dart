import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'botPlay.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';

double cardHeight = 190.0;
double cardWidth = 136.0;
TextStyle textTheme = TextStyle(color: Colors.orange[500]);

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: TextListWidget(),
        ),
      ),
    );
  }
}

class TextListWidget extends StatefulWidget {
  @override
  _TextListWidgetState createState() => _TextListWidgetState();
}

class _TextListWidgetState extends State<TextListWidget> {
  final StringArrayNotifier centralDeck = StringArrayNotifier([]);
  List<String> communityCards = [];
  List<String> Bothand = [];
  List<String> playerHand = [];
  final botA = Botplay();
  late double probA;

  int count = 0;
  List<FlipCardController> listController = [
    FlipCardController(), //midcard 0
    FlipCardController(), //midcard 1
    FlipCardController(), //midcard 2
    FlipCardController(), //midcard 3
    FlipCardController(), //midcard 4
    FlipCardController(), //botcard 0
    FlipCardController(), //botcard 1
  ];

  @override
  void initState() {
    super.initState();
    communityCards = centralDeck.drawNcard(5);
    Bothand = centralDeck.drawNcard(2);
    playerHand = centralDeck.drawNcard(2);
  }

  @override
  Widget build(BuildContext context) {
    var tempCommuCards = botA.cardPpare(communityCards);
    var tempBotH = botA.cardPpare(Bothand);
    var tempPlayH = botA.cardPpare(playerHand);
    probA = botA.monteEvaluate(tempBotH, tempPlayH, tempCommuCards);
    var stateText = botA.currentState;
    var logger = Logger();

    return ValueListenableBuilder<List<String>>(
      valueListenable: centralDeck,
      builder: (context, stringArray, child) {
        return Container(
          color: Colors.green[900],
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlipCard(
                  rotateSide: RotateSide.right,
                  frontWidget: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.black)),
                    height: cardHeight,
                    width: cardWidth,
                    child: Image.asset(
                      ("assets/images/BC.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                  backWidget: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.black)),
                    height: cardHeight,
                    width: cardWidth,
                    child: Image.asset(
                      ("assets/images/${Bothand[0]}.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                  controller: listController[5],
                ),
                FlipCard(
                  rotateSide: RotateSide.right,
                  frontWidget: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.black)),
                    height: cardHeight,
                    width: cardWidth,
                    child: Image.asset(
                      ("assets/images/BC.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                  backWidget: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.black)),
                    height: cardHeight,
                    width: cardWidth,
                    child: Image.asset(
                      ("assets/images/${Bothand[1]}.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                  controller: listController[6],
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            ShowCards(context),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.black)),
                  height: cardHeight,
                  width: cardWidth,
                  child: Image.asset(
                    ("assets/images/${playerHand[0]}.png"),
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.black)),
                  height: cardHeight,
                  width: cardWidth,
                  child: Image.asset(
                    ("assets/images/${playerHand[1]}.png"),
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      // We play
                      botA.changeState(probA, 1);

                      if (botA.currentState == 'A Win' ||
                          botA.currentState == 'B Win' ||
                          botA.currentState == 'Draw') {
                        listController[5].flipcard();
                        listController[6].flipcard();
                      }

                      if (botA.round == 1 && botA.currentState == 'Advance') {
                        listController[0].flipcard();
                        listController[1].flipcard();
                        listController[2].flipcard();
                      } else if (botA.round == 2 &&
                          botA.currentState == 'Advance') {
                        listController[3].flipcard();
                      } else if (botA.round == 3 &&
                          botA.currentState == 'Advance') {
                        listController[4].flipcard();
                      }

                      setState(() {
                        stateText = botA.currentState;
                      });
                    },
                    child: Text(
                      "Call or Check",
                      style: textTheme,
                    )),
                TextButton(
                    onPressed: () {
                      // We play
                      botA.changeState(probA, 0);

                      if (botA.currentState == 'A Win' ||
                          botA.currentState == 'B Win' ||
                          botA.currentState == 'Draw') {
                        listController[5].flipcard();
                        listController[6].flipcard();
                      }

                      if (botA.round == 1 && botA.currentState == 'Advance') {
                        listController[0].flipcard();
                        listController[1].flipcard();
                        listController[2].flipcard();
                      } else if (botA.round == 2 &&
                          botA.currentState == 'Advance') {
                        listController[3].flipcard();
                      } else if (botA.round == 3 &&
                          botA.currentState == 'Advance') {
                        listController[4].flipcard();
                      }

                      setState(() {
                        stateText = botA.currentState;
                      });
                    },
                    child: Text(
                      "Fold",
                      style: textTheme,
                    )),
                TextButton(
                    onPressed: () {
                      // We play
                      botA.changeState(probA, 2);

                      if (botA.currentState == 'A Win' ||
                          botA.currentState == 'B Win' ||
                          botA.currentState == 'Draw') {
                        listController[5].flipcard();
                        listController[6].flipcard();
                      }

                      if (botA.round == 1 && botA.currentState == 'Advance') {
                        listController[0].flipcard();
                        listController[1].flipcard();
                        listController[2].flipcard();
                      } else if (botA.round == 2 &&
                          botA.currentState == 'Advance') {
                        listController[3].flipcard();
                      } else if (botA.round == 3 &&
                          botA.currentState == 'Advance') {
                        listController[4].flipcard();
                      }

                      setState(() {
                        stateText = botA.currentState;
                      });
                    },
                    child: Text(
                      "Bet",
                      style: textTheme,
                    )),
                RichText(
                  text: TextSpan(
                    text: stateText,
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.amberAccent[300],
                      background: Paint()
                        ..style = PaintingStyle.fill
                        ..color = Colors.blue[700]!,
                    ),
                  ),
                )
              ],
            ),
          ]),
        );
      },
    );
  }

  Widget ShowCards(BuildContext context) {
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        FlipCard(
          rotateSide: RotateSide.right,
          frontWidget: Container(
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.black)),
            height: cardHeight,
            width: cardWidth,
            child: Image.asset(
              ("assets/images/BC.png"),
              fit: BoxFit.contain,
            ),
          ),
          backWidget: Container(
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.black)),
            height: cardHeight,
            width: cardWidth,
            child: Image.asset(
              ("assets/images/${communityCards[0]}.png"),
              fit: BoxFit.contain,
            ),
          ),
          controller: listController[0],
        ),
        FlipCard(
          rotateSide: RotateSide.right,
          frontWidget: Container(
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.black)),
            height: cardHeight,
            width: cardWidth,
            child: Image.asset(
              ("assets/images/BC.png"),
              fit: BoxFit.contain,
            ),
          ),
          backWidget: Container(
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.black)),
            height: cardHeight,
            width: cardWidth,
            child: Image.asset(
              ("assets/images/${communityCards[1]}.png"),
              fit: BoxFit.contain,
            ),
          ),
          controller: listController[1],
        ),
        FlipCard(
          rotateSide: RotateSide.right,
          frontWidget: Container(
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.black)),
            height: cardHeight,
            width: cardWidth,
            child: Image.asset(
              ("assets/images/BC.png"),
              fit: BoxFit.contain,
            ),
          ),
          backWidget: Container(
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.black)),
            height: cardHeight,
            width: cardWidth,
            child: Image.asset(
              ("assets/images/${communityCards[2]}.png"),
              fit: BoxFit.contain,
            ),
          ),
          controller: listController[2],
        ),
        FlipCard(
          rotateSide: RotateSide.right,
          frontWidget: Container(
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.black)),
            height: cardHeight,
            width: cardWidth,
            child: Image.asset(
              ("assets/images/BC.png"),
              fit: BoxFit.contain,
            ),
          ),
          backWidget: Container(
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.black)),
            height: cardHeight,
            width: cardWidth,
            child: Image.asset(
              ("assets/images/${communityCards[3]}.png"),
              fit: BoxFit.contain,
            ),
          ),
          controller: listController[3],
        ),
        FlipCard(
          rotateSide: RotateSide.right,
          frontWidget: Container(
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.black)),
            height: cardHeight,
            width: cardWidth,
            child: Image.asset(
              ("assets/images/BC.png"),
              fit: BoxFit.contain,
            ),
          ),
          backWidget: Container(
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.black)),
            height: cardHeight,
            width: cardWidth,
            child: Image.asset(
              ("assets/images/${communityCards[4]}.png"),
              fit: BoxFit.contain,
            ),
          ),
          controller: listController[4],
        ),
      ]),
    );
  }
}
