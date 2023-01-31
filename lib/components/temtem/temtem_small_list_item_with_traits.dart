import 'package:flutter/material.dart';
import 'package:tempedia/components/temtem/temtem_small_item.dart';
import 'package:tempedia/components/temtem/temtem_trait_name.dart';
import 'package:tempedia/models/temtem.dart';

class TemtemListItemWithTraits extends StatefulWidget {
  final Temtem data;
  const TemtemListItemWithTraits({super.key, required this.data});

  @override
  State<StatefulWidget> createState() => _TemtemListItemWithTraitsState();
}

class _TemtemListItemWithTraitsState extends State<TemtemListItemWithTraits> {
  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    return TemtemSmallItem(
      data: data,
      child: SizedBox(
        width: 100,
        child: Column(
          children: [
            TemtemTraitName(
              name: data.traits[0],
              color: const Color(0xFFbce2e3),
            ),
            Container(
              margin: const EdgeInsets.only(top: 2),
              child: TemtemTraitName(
                name: data.traits[1],
                color: const Color(0xFFebd6c2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
