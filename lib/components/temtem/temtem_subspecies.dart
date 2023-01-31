import 'package:flutter/material.dart';
import 'package:tempedia/components/expandable_tabview.dart';
import 'package:tempedia/components/temtem/temtem_icon.dart';
import 'package:tempedia/models/temtem.dart';

class TemtemSubspecies extends StatefulWidget {
  final List<TemtemSubspecie> subspecies;
  const TemtemSubspecies({super.key, required this.subspecies});

  @override
  State<StatefulWidget> createState() => _TemtemSubspeciesState();
}

class _TemtemSubspeciesState extends State<TemtemSubspecies> {
  @override
  Widget build(BuildContext context) {
    List<String> tabs = [];
    List<Widget> children = [];

    for (var sub in widget.subspecies) {
      tabs.add(sub.type);
      children.add(
        Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TemtemIcon(
                fileid: sub.icon,
                size: 120,
                tappable: true,
                // tag: 'subspecie-${sub.type}-icon',
              ),
              TemtemIcon(
                fileid: sub.lumaIcon,
                size: 120,
                tappable: true,
                // tag: 'subspecie-${sub.type}-luma-icon',
              )
            ],
          ),
        ),
      );
    }

    return ExpandableTabView(tabs: tabs, children: children);
  }
}
