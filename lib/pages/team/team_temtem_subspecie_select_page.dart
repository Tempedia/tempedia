import 'package:flutter/material.dart';
import 'package:tempedia/components/temtem/temtem_icon.dart';
import 'package:tempedia/components/temtem/temtem_type_icon.dart';
import 'package:tempedia/models/technique.dart';
import 'package:tempedia/models/temtem.dart';

class TeamTemtemSubspecieSelectPage extends StatefulWidget {
  final Temtem data;
  const TeamTemtemSubspecieSelectPage({super.key, required this.data});

  @override
  State<StatefulWidget> createState() => _TeamTemtemSubspecieSelectPageState();
}

class _TeamTemtemSubspecieSelectPageState
    extends State<TeamTemtemSubspecieSelectPage> {
  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Subspecie'),
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(10),
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        crossAxisCount: 2,
        childAspectRatio: 1,
        children: data.subspecies.map((e) => buildCard(e)).toList(),
      ),
    );
  }

  Widget buildCard(TemtemSubspecie e) {
    final data = widget.data;

    return Card(
      child: InkWell(
        onTap: (() {
          var type = [data.type[0]];
          var t = '${e.type} type';
          if (data.type[0] != t) {
            type.add(t);
          }
          List<TemtemLevelingUpTechnique> levelingUpTechniques = [];
          if (data.techniqueGroup != null) {
            for (var t in data.techniqueGroup!.levelingUp) {
              if (t.group.isNotEmpty && t.group != e.type) {
                continue;
              }
              levelingUpTechniques.add(t);
            }
          }
          var d = Temtem(
            no: data.no,
            name: data.name,
            icon: e.icon,
            lumaIcon: e.lumaIcon,
            type: type,
            traits: data.traits,
            description: data.description,
            cry: data.cry,
            height: data.height,
            weight: data.weight,
            genderRatio: data.genderRatio,
            tvYield: data.tvYield,
            stats: data.stats,
            typeMatchup: data.typeMatchup,
            gallery: data.gallery,
            renders: data.renders,
            evolvesTo: data.evolvesTo,
            subspecies: data.subspecies,
            subspecie: e,
            techniqueGroup: TemtemTechniqueGroup(
              levelingUp: levelingUpTechniques,
              course: data.techniqueGroup!.course,
              breeding: data.techniqueGroup!.breeding,
            ),
          );
          Navigator.pop(
            context,
            d,
          );
        }),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TemtemIcon(fileid: e.icon),
              Container(
                margin: const EdgeInsets.only(top: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TemtemTypeIcon(name: data.type[0]),
                    '${e.type} type' != data.type[0]
                        ? TemtemTypeIcon(name: '${e.type} type')
                        : Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
