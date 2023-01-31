import 'package:flutter/material.dart';
import 'package:tempedia/components/temtem/temtem_breeding_technique_item.dart';
import 'package:tempedia/models/technique.dart';

class TemtemBreedingTechniquesList extends StatelessWidget {
  final List<TemtemBreedingTechnique>? techniques;
  final String name;

  const TemtemBreedingTechniquesList(
      {super.key, required this.techniques, required this.name});

  @override
  Widget build(BuildContext context) {
    if (techniques != null && techniques!.isEmpty) {
      return Container(
        alignment: Alignment.center,
        height: 60,
        child: Text(
          '$name doesn\'t gain any techniques through Breeding.',
          style: const TextStyle(fontSize: 12),
        ),
      );
    }
    return Column(
      children: techniques
              ?.map((e) => TemtemBreedingTechniqueItem(
                    data: e,
                  ))
              .toList() ??
          [],
    );
  }
}
