import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:poker_bot/backend.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';

double cardHeight = 190.0;
double cardWidth = 136.0;
TextStyle textTheme = TextStyle(color: Colors.orange[500]);


void main() async {
  runApp(MyApp());
}

/* class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
} */

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // appBar: AppBar(
        //   title: const Text('Text Notifier Example'),
        // ),
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
  final StringArrayNotifier textNotifier = StringArrayNotifier([]);
  final StringArrayNotifier botHand = StringArrayNotifier([]);
  final StringArrayNotifier playerHand = StringArrayNotifier([]);

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
    textNotifier.value = TextNotifier().stringArray;
    botHand.value = BotHand().stringArray;
    playerHand.value = PlayerHand().stringArray;
    // textNotifier.updateValue(newValue);
  }

  // @override
  // Widget build(BuildContext context) {
  //   return ValueListenableBuilder<List<String>>(
  //     valueListenable: textNotifier,
  //     builder: (context, stringArray, child) {
  //       return Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children:[
  //         ShowCards(textNotifier.value),
  //         Text("Hello"),
  //         ] /* [
  //           for (var text in stringArray)
  //             Text(
  //               text,
  //               style: TextStyle(fontSize: 24),
  //             ),
  //         ], */
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<String>>(
      valueListenable: textNotifier,
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
                      ("assets/images/${botHand.value[0]}.png"),
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
                      ("assets/images/${botHand.value[1]}.png"),
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
                    ("assets/images/${playerHand.value[0]}.png"),
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
                    ("assets/images/${playerHand.value[1]}.png"),
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Call",
                      style: textTheme,
                    )),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Fold",
                      style: textTheme,
                    )),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Bet",
                      style: textTheme,
                    )),
                FloatingActionButton(onPressed: () {
                  count++;
                  if (count == 1) {
                    listController[0].flipcard();
                    listController[1].flipcard();
                    listController[2].flipcard();
                    count = 2;
                  } else {
                    listController[count].flipcard();
                  }
                })
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
              ("assets/images/${textNotifier.value[0]}.png"),
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
              ("assets/images/${textNotifier.value[1]}.png"),
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
              ("assets/images/${textNotifier.value[2]}.png"),
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
              ("assets/images/${textNotifier.value[3]}.png"),
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
              ("assets/images/${textNotifier.value[4]}.png"),
              fit: BoxFit.contain,
            ),
          ),
          controller: listController[4],
        ),
      ]),
    );
  }
}
