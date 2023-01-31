import 'package:flutter/material.dart';
import 'package:tempedia/api/condition.dart' as api;
import 'package:tempedia/components/loading.dart';
import 'package:tempedia/components/temtem/temtem_base_technique_item.dart';
import 'package:tempedia/models/condition.dart';
import 'package:tempedia/models/technique.dart';
import 'package:tempedia/pages/temtem_technique_page.dart';
import 'package:tempedia/utils/transition.dart';

class TemtemStatusConditionTechniqueList extends StatefulWidget {
  final TemtemStatusCondition condition;

  const TemtemStatusConditionTechniqueList(
      {super.key, required this.condition});

  @override
  State<StatefulWidget> createState() =>
      _TemtemStatusConditionTechniqueListState();
}

class _TemtemStatusConditionTechniqueListState
    extends State<TemtemStatusConditionTechniqueList> {
  List<TemtemTechnique> techniques = [];

  @override
  void initState() {
    super.initState();
    findTemtemTechniques();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Loading();
    }
    return techniques.isNotEmpty
        ? Column(
            children: techniques
                .map(
                  (e) => TemtemBaseTechniqueItem(
                    data: TemtemTechqniueBase(stab: false, technique: e),
                    child: Container(),
                  ),
                )
                .toList(),
          )
        : Container(
            padding: const EdgeInsets.all(10),
            child: const Text('No Related Technique'),
          );
  }

  bool loading = false;
  findTemtemTechniques() async {
    try {
      setState(() {
        loading = true;
      });
      techniques =
          await api.findTemtemStatusConditionTechniques(widget.condition.name);
    } catch (e) {
    } finally {
      setState(() {
        loading = false;
      });
    }
  }
}
