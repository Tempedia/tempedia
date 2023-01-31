import 'package:flutter/material.dart';
import 'package:tempedia/api/temtem.dart' as api;
import 'package:tempedia/components/temtem/temtem_evolution_item.dart';
import 'package:tempedia/components/temtem/temtem_evolve_method.dart';
import 'package:tempedia/models/temtem.dart';

class TemtemEvolutionFrom extends StatefulWidget {
  final String name;
  const TemtemEvolutionFrom({super.key, required this.name});

  @override
  State<StatefulWidget> createState() => _TemtemEvolutionFromState();
}

class _TemtemEvolutionFromState extends State<TemtemEvolutionFrom> {
  Temtem? data;

  @override
  void initState() {
    super.initState();

    findTemtemEvolvesFrom();
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return Container();
    }
    TemtemEvolvesTo? method;
    for (var m in data!.evolvesTo) {
      if (m.to == widget.name) {
        method = m;
        break;
      }
    }
    return Row(
      children: [
        TemtemEvolutionFrom(name: data!.name),
        TemtemEvolutionItem(data: data!),
        method != null ? TemtemEvolveMethod(method: method) : Container(),
      ],
    );
  }

  findTemtemEvolvesFrom() async {
    try {
      final temtems = await api.findTemtemEvolvesFrom(widget.name);
      if (temtems.isNotEmpty) {
        data = temtems[0];
      }
      setState(() {});
    } finally {}
  }
}
