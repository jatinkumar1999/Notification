import 'package:authenticateuser/Animation/Shake_Animation.dart';
import 'package:authenticateuser/BouncingCard.dart';
import 'package:authenticateuser/Card_Data.dart';
import 'package:authenticateuser/Card_Modal/cardModal.dart';
import 'package:flutter/material.dart';

class CardShowing extends StatefulWidget {
  CardShowing({Key key}) : super(key: key);

  @override
  _CardShowingState createState() => _CardShowingState();
}

class _CardShowingState extends State<CardShowing> {
  @override
  Widget build(BuildContext context) {
    int currentindex = 0;
    final pageController = PageController(
      viewportFraction: 0.7,
    );
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(24),
        child: PageView.builder(
            physics: const BouncingScrollPhysics(),
            controller: pageController,
            itemCount: Data.cards.length,
            onPageChanged: (int index) {
              setState(() {
                currentindex = index;
              });
            },
            itemBuilder: (context, index) {
              final data = Data.cards[index];
              final card = BouncingCard(
                  color: data.color,
                  description: data.description,
                  imgUrl: data.imgUrl,
                  subtitle: data.subtitle,
                  title: data.title);

              if (currentindex == index) {
                return LeftRightwidget(child: card);
              }
              return card;
            }),
      ),
    );
  }
}
