import 'package:flutter/material.dart';

class TemtemTraitName extends StatelessWidget {
  final String name;
  final Color color;
  final double? width;
  final EdgeInsets padding;
  final String? tag;
  final double fontSize;
  const TemtemTraitName({
    super.key,
    required this.name,
    this.color = const Color(0xFFbce2e3),
    this.width = double.infinity,
    this.padding = const EdgeInsets.only(left: 2, right: 2, bottom: 2, top: 2),
    this.tag,
    this.fontSize = 12,
  });

  @override
  Widget build(BuildContext context) {
    if (tag == null) {
      return buildWidget();
    }
    return Hero(
      tag: '$tag-$name',
      child: Material(
        color: Colors.transparent,
        child: FittedBox(
          child: buildWidget(),
        ),
      ),
    );
  }

  buildWidget() {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(1)),
        color: color,
      ),
      padding: padding,
      child: Text(
        name,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: fontSize,
          color: const Color(0xFF78617a),
          // overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
