import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:poker_bot/ShowCards.dart';
import 'package:poker_bot/backend.dart';

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
        appBar: AppBar(
          title: const Text('Text Notifier Example'),
        ),
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
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.center,
              child: ShowCards(botHand.value),
            ),
            ShowCards(textNotifier.value),
            Container(
              alignment: Alignment.center,
              child: ShowCards(playerHand.value),
            ),
          ],
        );
      },
    );
  }
}
