import 'package:flutter/material.dart';
import 'package:tempedia/components/temtem/temtem_course_technique_item.dart';
import 'package:tempedia/models/technique.dart';

class TemtemCourseTechniquesList extends StatelessWidget {
  final List<TemtemCourseTechnique>? techniques;
  final String name;

  const TemtemCourseTechniquesList(
      {super.key, required this.techniques, required this.name});

  @override
  Widget build(BuildContext context) {
    if (techniques != null && techniques!.isEmpty) {
      return Container(
        alignment: Alignment.center,
        height: 60,
        child: Text(
          '$name doesn\'t learn any techniques by Technique Course.',
          style: const TextStyle(fontSize: 12),
        ),
      );
    }
    return Column(
      children: techniques
              ?.map((e) => TemtemCourseTechniqueItem(
                    data: e,
                  ))
              .toList() ??
          [],
    );
  }
}
