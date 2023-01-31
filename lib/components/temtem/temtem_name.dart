import 'package:flutter/material.dart';

class TemtemName extends StatelessWidget {
  final String name;
  final double size;
  final String? tag;

  const TemtemName({
    super.key,
    required this.name,
    this.size = 24,
    this.tag,
  });

  @override
  Widget build(BuildContext context) {
    if (tag == null) {
      return buildText();
    }
    return Hero(
      tag: '$tag - $name',
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
      name,
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w500,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }
}
