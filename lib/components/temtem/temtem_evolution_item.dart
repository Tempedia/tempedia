import 'package:flutter/material.dart';
import 'package:tempedia/components/temtem/temtem_icon.dart';
import 'package:tempedia/components/temtem/temtem_trait_name.dart';
import 'package:tempedia/components/temtem/temtem_type_icon.dart';
import 'package:tempedia/models/temtem.dart';
import 'package:tempedia/pages/temtem_page.dart';
import 'package:tempedia/utils/transition.dart';

class TemtemEvolutionItem extends StatefulWidget {
  final Temtem data;
  const TemtemEvolutionItem(
      {super.key, required this.data, this.disableTap = false});
  final bool disableTap;

  @override
  State<StatefulWidget> createState() => _TemtemEvolutionItemState();
}

class _TemtemEvolutionItemState extends State<TemtemEvolutionItem> {
  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    return Card(
      child: InkWell(
        onTap: () {
          if (widget.disableTap) {
            return;
          }
          Navigator.push(context,
              DefaultMaterialPageRoute(builder: (_) => TemtemPage(data: data)));
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          child: IntrinsicWidth(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                TemtemIcon(
                  fileid: data.icon,
                  size: 80,
                ),
                Text(
                  data.name,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: data.type
                      .map((e) => TemtemTypeIcon(
                            name: e,
                            size: 20,
                          ))
                      .toList(),
                ),
                createStatRow('HP', data.stats.hp.base),
                createStatRow('STA', data.stats.sta.base),
                createStatRow('SPD', data.stats.spd.base),
                createStatRow('ATK', data.stats.atk.base),
                createStatRow('DEF', data.stats.def.base),
                createStatRow('SPATK', data.stats.spatk.base),
                createStatRow('SPDEF', data.stats.spdef.base),
                Container(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: const Text(
                    'Traits',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                  ),
                ),
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
        ),
      ),
    );
  }

  createStatRow(String name, int v) {
    return Container(
      padding: const EdgeInsets.only(left: 6, right: 6, top: 2),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          ),
          Text(
            '$v',
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
