import 'package:flutter/material.dart';
import 'package:tempedia/components/temtem/temtem_base_technique_item.dart';
import 'package:tempedia/components/temtem/temtem_icon_from_name.dart';
import 'package:tempedia/models/technique.dart';
import 'package:tempedia/pages/temtem_technique_page.dart';
import 'package:tempedia/utils/transition.dart';

class TemtemBreedingTechniqueItem extends StatefulWidget {
  final TemtemBreedingTechnique data;
  const TemtemBreedingTechniqueItem({super.key, required this.data});

  @override
  State<StatefulWidget> createState() => _TemtemBreedingTechniqueItemState();
}

class _TemtemBreedingTechniqueItemState
    extends State<TemtemBreedingTechniqueItem> {
  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    return TemtemBaseTechniqueItem(
      data: data,
      childPosition: TemtemBaseTechniqueItemChildPosition.bottom,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Container(
          padding: const EdgeInsets.only(top: 10, left: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: data.parents
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
    );
  }
}
