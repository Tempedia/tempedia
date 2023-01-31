import 'package:flutter/material.dart';
import 'package:tempedia/api/temtem.dart' as api;
import 'package:tempedia/components/temtem/temtem_evolution_from.dart';
import 'package:tempedia/components/temtem/temtem_evolution_item.dart';
import 'package:tempedia/components/temtem/temtem_evolve_method.dart';
import 'package:tempedia/models/temtem.dart';

class TemtemEvolutionTo extends StatefulWidget {
  final String? name;
  final Temtem? data;
  final bool from;

  const TemtemEvolutionTo({super.key, this.name, this.data, this.from = false})
      : assert(name != null || data != null);

  @override
  State<StatefulWidget> createState() => _TemtemEvolutionToState();
}

class _TemtemEvolutionToState extends State<TemtemEvolutionTo> {
  Temtem? data;

  @override
  void initState() {
    super.initState();

    if (widget.data == null) {
      getTemtem(widget.name!);
    } else {
      data = widget.data;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return Container();
    }
    if (data!.evolvesTo.isEmpty) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(children: [
          widget.from ? TemtemEvolutionFrom(name: data!.name) : Container(),
          TemtemEvolutionItem(
            data: data!,
            disableTap: widget.from,
          ),
        ]),
      );
    }
    return Column(
      children: data?.evolvesTo
              .map(
                (e) => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      widget.from
                          ? TemtemEvolutionFrom(name: data!.name)
                          : Container(),
                      TemtemEvolutionItem(
                        data: data!,
                        disableTap: widget.from,
                      ),
                      TemtemEvolveMethod(method: e),
                      TemtemEvolutionTo(
                        name: e.to,
                      ),
                    ],
                  ),
                ),
              )
              .toList() ??
          [],
    );
  }

  getTemtem(String name) async {
    try {
      data = await api.getTemtem(name);
      setState(() {});
    } finally {}
  }
}
