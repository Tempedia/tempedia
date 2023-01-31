import 'package:flutter/material.dart';

class GenderIcon extends StatelessWidget {
  final String gender;
  final double? size;
  final String? tag;
  const GenderIcon({super.key, required this.gender, this.size, this.tag});

  @override
  Widget build(BuildContext context) {
    if (tag == null) {
      return buildIcon();
    }
    return Hero(
      tag: '$tag-#$gender',
      child: Material(
        color: Colors.transparent,
        child: buildIcon(),
      ),
    );
  }

  Widget buildIcon() {
    if (gender == 'male') {
      return Icon(
        Icons.male,
        size: size,
        color: Colors.blue,
      );
    } else if (gender == 'female') {
      return Icon(
        Icons.female,
        size: size,
        color: Colors.pink,
      );
    }
    return Container();
  }
}
