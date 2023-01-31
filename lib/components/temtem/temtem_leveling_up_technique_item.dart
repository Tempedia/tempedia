import 'package:flutter/material.dart';
import 'package:tempedia/components/temtem/temtem_base_technique_item.dart';
import 'package:tempedia/models/technique.dart';
import 'package:tempedia/pages/temtem_technique_page.dart';
import 'package:tempedia/utils/transition.dart';

class TemtemLevelingUpTechniqueItem extends StatefulWidget {
  final TemtemLevelingUpTechnique data;
  const TemtemLevelingUpTechniqueItem({super.key, required this.data});

  @override
  State<StatefulWidget> createState() => _TemtemLevelingUpTechniqueItemState();
}

class _TemtemLevelingUpTechniqueItemState
    extends State<TemtemLevelingUpTechniqueItem> {
  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    return TemtemBaseTechniqueItem(
      data: data,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('lv.'),
          Text(
            '${data.level}',
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
