import 'package:flutter/material.dart';

class TemtemNO extends StatelessWidget {
  final String no;
  final double size;
  final String? tag;

  const TemtemNO({super.key, required this.no, this.size = 14, this.tag});

  @override
  Widget build(BuildContext context) {
    if (tag == null) {
      return buildText();
    }
    return Hero(
      tag: '$tag-#$no',
      child: Material(
        color: Colors.transparent,
        child: FittedBox(
          child: buildText(),
        ),
      ),
    );
  }

  Widget buildText() {
    return Text(
      '#$no',
      style: TextStyle(
        fontSize: size,
        color: Colors.grey,
      ),
    );
  }
}
