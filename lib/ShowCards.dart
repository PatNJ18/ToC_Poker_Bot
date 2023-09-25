import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ShowCards extends StatelessWidget {
  List<String> card;
  ShowCards(this.card);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 243,
                                                        width: 175 * card.length.toDouble(),
                                                        constraints: BoxConstraints(
                                                          maxWidth: MediaQuery.of(context).size.width * 1,
                                                        ),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: card.length,
            itemBuilder: (BuildContext context, int index) {
              String tmp = "assets/images/";
              tmp += (card[index] + ".png");
              return Container(
                width: 175,
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Image.asset(
                  tmp,
                  fit: BoxFit.contain,
                ),
              );
            }));
  }
}
