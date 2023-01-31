import 'package:flutter/material.dart';
import 'package:tempedia/components/temtem/temtem_type_icon.dart';

class TemtemTechniqueSynergyIcon extends StatelessWidget {
  final String type;
  final double size;
  const TemtemTechniqueSynergyIcon(
      {super.key, required this.type, this.size = 22});

  @override
  Widget build(BuildContext context) {
    if (type.isEmpty) {
      return Container();
    }
    return Row(
      children: [
        const Text(' (+'),
        TemtemTypeIcon(
          name: type,
          size: size,
        ),
        const Text(')'),
      ],
    );
  }
}
