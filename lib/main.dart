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
      home: Scaffold(
        appBar: AppBar(
          title: Text('Text Notifier Example'),
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

  @override
  void initState() {
    super.initState();
    textNotifier.value = TextNotifier().stringArray;
    //textNotifier.updateValue(newValue);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<String>>(
      valueListenable: textNotifier,
      builder: (context, stringArray, child) {
        return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ShowCards(textNotifier.value)
        ] /* [
            for (var text in stringArray)
              Text(
                text,
                style: TextStyle(fontSize: 24),
              ),
          ], */
            );
      },
    );
  }
}
