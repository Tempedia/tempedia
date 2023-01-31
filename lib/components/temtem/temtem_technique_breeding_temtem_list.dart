import 'package:flutter/material.dart';
import 'package:tempedia/components/temtem/temtem_icon_from_name.dart';
import 'package:tempedia/components/temtem/temtem_small_item.dart';
import 'package:tempedia/models/technique.dart';

class TemtemTechniqueBreedingTemtemItem extends StatefulWidget {
  final TemtemBreedingTechnique technique;
  TemtemTechniqueBreedingTemtemItem({super.key, required this.technique})
      : assert(technique.temtem != null);

  @override
  State<StatefulWidget> createState() =>
      _TemtemTechniqueBreedingTemtemItemState();
}

class _TemtemTechniqueBreedingTemtemItemState
    extends State<TemtemTechniqueBreedingTemtemItem> {
  @override
  Widget build(BuildContext context) {
    final data = widget.technique.temtem!;
    return TemtemSmallItem(
      data: data,
      child: Expanded(
        // width: 180,
        flex: 10,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Container(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: widget.technique.parents
                  .map(
                    (e) => Column(
                      children: [
                        TemtemIconFromName(
                          name: e.name,
                          size: 30,
                        ),
                        Text(e.hint),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class TemtemTechniqueBreedingTemtemList extends StatelessWidget {
  final List<TemtemBreedingTechnique> temtems;

  const TemtemTechniqueBreedingTemtemList({super.key, required this.temtems});

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
          .map((e) => TemtemTechniqueBreedingTemtemItem(
                technique: e,
              ))
          .toList(),
    );
  }
}
