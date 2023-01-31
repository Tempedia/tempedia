import 'package:flutter/material.dart';

class TextTag extends StatelessWidget {
  final String text;
  final double textSize;

  final EdgeInsetsGeometry padding;

  const TextTag({
    super.key,
    required this.text,
    this.textSize = 12,
    this.padding = const EdgeInsets.only(left: 7, right: 7, top: 4, bottom: 4),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: const Color(0xFFd9d9d9)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: textSize,
        ),
      ),
    );
  }
}
