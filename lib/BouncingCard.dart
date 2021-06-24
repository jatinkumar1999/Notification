import 'package:flutter/material.dart';

class BouncingCard extends StatefulWidget {
  final String title;
  final String description;
  final String imgUrl;
  final String subtitle;
  final Color color;
  BouncingCard(
      {this.title,
      this.imgUrl,
      this.color,
      this.description,
      this.subtitle,
      Key key})
      : super(key: key);

  @override
  _BouncingCardState createState() => _BouncingCardState();
}

class _BouncingCardState extends State<BouncingCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Card(
          clipBehavior: Clip.hardEdge,
          shape: const StadiumBorder(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: buildImage(),
              ),
              Expanded(
                child: buildText(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildImage() => Image.asset(
        widget.imgUrl,
        fit: BoxFit.cover,
        width: double.infinity,
      );
  buildText() => Container(
        padding: const EdgeInsets.all(10),
        color: widget.color,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title),
            const SizedBox(height: 6),
            Text(widget.subtitle),
            const SizedBox(height: 6),
            Text(widget.description),
          ],
        ),
      );
}
