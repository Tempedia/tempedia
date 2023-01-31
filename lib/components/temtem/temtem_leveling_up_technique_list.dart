import 'package:flutter/material.dart';
import 'package:tempedia/components/expandable_tabview.dart';
import 'package:tempedia/components/temtem/temtem_leveling_up_technique_item.dart';
import 'package:tempedia/models/technique.dart';

class TemtemLevelingUpTechniquesList extends StatelessWidget {
  final List<TemtemLevelingUpTechnique>? techniques;
  final String name;

  const TemtemLevelingUpTechniquesList(
      {super.key, required this.techniques, required this.name});

  @override
  Widget build(BuildContext context) {
    final techniques = this.techniques;
    if (techniques == null) {
      return Container();
    } else if (techniques.isEmpty) {
      return Container(
        alignment: Alignment.center,
        height: 60,
        child: Text(
          '$name doesn\'t learn any techniques by Leveling Up.',
          style: const TextStyle(fontSize: 12),
        ),
      );
    }

    List<String> groups = [];
    for (var t in techniques) {
      if (t.group.isNotEmpty && !groups.contains(t.group)) {
        groups.add(t.group);
      }
    }
    if (groups.isEmpty) {
      return _createTemtemLevelUpTechniqueList(techniques);
    }

    final groupTechniques = List<List<TemtemLevelingUpTechnique>>.generate(
      groups.length,
      (_) => <TemtemLevelingUpTechnique>[],
    );

    for (var i = 0; i < groups.length; i++) {
      for (var t in techniques) {
        if (t.group == groups[i]) {
          groupTechniques[i].add(t);
        }
      }
    }

    return ExpandableTabView(
        tabs: groups,
        children: groupTechniques
            .map(
              (e) => _createTemtemLevelUpTechniqueList(e),
            )
            .toList());
  }

  Widget _createTemtemLevelUpTechniqueList(
      List<TemtemLevelingUpTechnique> list) {
    return Column(
      children: list
          .map((e) => TemtemLevelingUpTechniqueItem(
                data: e,
              ))
          .toList(),
    );
  }
}
