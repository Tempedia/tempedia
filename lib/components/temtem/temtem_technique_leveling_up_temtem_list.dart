import 'package:flutter/material.dart';
import 'package:tempedia/components/temtem/temtem_small_item.dart';
import 'package:tempedia/models/technique.dart';

class TemtemTechniqueLevelingUpTemtemItem extends StatefulWidget {
  final TemtemLevelingUpTechnique technique;
  TemtemTechniqueLevelingUpTemtemItem({super.key, required this.technique})
      : assert(technique.temtem != null);

  @override
  State<StatefulWidget> createState() =>
      _TemtemTechniqueLevelingUpTemtemItemState();
}

class _TemtemTechniqueLevelingUpTemtemItemState
    extends State<TemtemTechniqueLevelingUpTemtemItem> {
  @override
  Widget build(BuildContext context) {
    final data = widget.technique.temtem!;
    return TemtemSmallItem(
      data: data,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('lv.'),
          Text(
            '${widget.technique.level}',
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

class TemtemTechniqueLevelingUpTemtemList extends StatelessWidget {
  final List<TemtemLevelingUpTechnique> temtems;

  const TemtemTechniqueLevelingUpTemtemList({super.key, required this.temtems});

  @override
  Widget build(BuildContext context) {
    if (temtems.isEmpty) {
      return Container(
        alignment: Alignment.center,
        height: 60,
        child: const Text(
          'No Temtem',
          style: TextStyle(fontSize: 12),
        ),
      );
    }
    return Column(
      children: temtems
          .map((e) => TemtemTechniqueLevelingUpTemtemItem(
                technique: e,
              ))
          .toList(),
    );
  }
}
