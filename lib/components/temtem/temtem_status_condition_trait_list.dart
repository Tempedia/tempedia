import 'package:flutter/material.dart';
import 'package:tempedia/api/condition.dart' as api;
import 'package:tempedia/components/loading.dart';
import 'package:tempedia/components/temtem/temtem_base_technique_item.dart';
import 'package:tempedia/components/temtem/temtem_trait_card.dart';
import 'package:tempedia/models/condition.dart';
import 'package:tempedia/models/technique.dart';
import 'package:tempedia/models/trait.dart';
import 'package:tempedia/pages/temtem_technique_page.dart';
import 'package:tempedia/pages/temtem_trait_page.dart';
import 'package:tempedia/utils/transition.dart';

class TemtemStatusConditionTraitList extends StatefulWidget {
  final TemtemStatusCondition condition;

  const TemtemStatusConditionTraitList({super.key, required this.condition});

  @override
  State<StatefulWidget> createState() => _TemtemStatusConditionTraitListState();
}

class _TemtemStatusConditionTraitListState
    extends State<TemtemStatusConditionTraitList> {
  List<TemtemTrait> traits = [];

  @override
  void initState() {
    super.initState();
    findTemtemTraits();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Loading();
    }
    return traits.isNotEmpty
        ? Column(
            children: traits
                .map(
                  (e) => TemtemTraitCard(
                    name: e.name,
                    data: e,
                  ),
                )
                .toList(),
          )
        : Container(
            padding: const EdgeInsets.all(10),
            child: const Text('No Related Trait'),
          );
  }

  bool loading = false;
  findTemtemTraits() async {
    try {
      setState(() {
        loading = true;
      });
      traits = await api.findTemtemStatusConditionTraits(widget.condition.name);
    } catch (e) {
    } finally {
      setState(() {
        loading = false;
      });
    }
  }
}
