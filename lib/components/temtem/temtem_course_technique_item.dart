import 'package:flutter/material.dart';
import 'package:tempedia/components/temtem/temtem_base_technique_item.dart';
import 'package:tempedia/models/technique.dart';
import 'package:tempedia/pages/temtem_technique_page.dart';
import 'package:tempedia/utils/transition.dart';

class TemtemCourseTechniqueItem extends StatefulWidget {
  final TemtemCourseTechnique data;
  const TemtemCourseTechniqueItem({super.key, required this.data});

  @override
  State<StatefulWidget> createState() => _TemtemCourseTechniqueItemState();
}

class _TemtemCourseTechniqueItemState extends State<TemtemCourseTechniqueItem> {
  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    return TemtemBaseTechniqueItem(
      data: data,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('#'),
          Text(
            data.course,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}
