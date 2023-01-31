import 'package:flutter/material.dart';
import 'package:tempedia/components/temtem/temtem_technique_class_icon.dart';
import 'package:tempedia/components/temtem/temtem_technique_priority_icon.dart';
import 'package:tempedia/components/temtem/temtem_technique_synergy_icon.dart';
import 'package:tempedia/components/temtem/temtem_type_icon.dart';
import 'package:tempedia/models/technique.dart';
import 'package:tempedia/pages/temtem_technique_page.dart';
import 'package:tempedia/utils/transition.dart';

enum TemtemBaseTechniqueItemChildPosition {
  top,
  right,
  bottom,
}

class TemtemBaseTechniqueItem extends StatefulWidget {
  final TemtemTechqniueBase data;
  const TemtemBaseTechniqueItem({
    super.key,
    required this.data,
    required this.child,
    this.childPosition = TemtemBaseTechniqueItemChildPosition.right,
  });

  final Widget child;
  final TemtemBaseTechniqueItemChildPosition childPosition;

  @override
  State<StatefulWidget> createState() => _TemtemBaseTechniqueItemState();
}

class _TemtemBaseTechniqueItemState extends State<TemtemBaseTechniqueItem> {
  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            DefaultMaterialPageRoute(
              builder: (context) => TemtemTechniquePage(data: data.technique),
            ),
          );
        },
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                widget.childPosition == TemtemBaseTechniqueItemChildPosition.top
                    ? widget.child
                    : Container(),
                Row(
                  children: [
                    Text(
                      data.technique.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                            data.stab ? FontWeight.w600 : FontWeight.w500,
                        fontStyle:
                            data.stab ? FontStyle.italic : FontStyle.normal,
                        decoration: data.stab
                            ? TextDecoration.underline
                            : TextDecoration.none,
                      ),
                    ),
                    TemtemTypeIcon(
                      name: data.technique.type,
                      size: 25,
                    ),
                    TemtemTechniqueSynergyIcon(
                      type: data.technique.synergyType,
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: TemtemTechniquePriorityIcon(
                          priority: data.technique.priority,
                          size: 25,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 200,
                      child: Table(
                        children: [
                          TableRow(
                            children: [
                              TableCell(
                                child: Row(
                                  children: [
                                    const Text('Class:       '),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.only(top: 2),
                                        alignment: Alignment.center,
                                        child: TemtemTechniqueClassIcon(
                                          cls: data.technique.cls,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              TableCell(
                                child: createText(
                                    'Damage:', data.technique.damage),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: createText(
                                    'STA Cost:', data.technique.staCost),
                              ),
                              TableCell(
                                child: createText(
                                    'Hold:      ', data.technique.hold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    widget.childPosition ==
                            TemtemBaseTechniqueItemChildPosition.right
                        ? Expanded(
                            child: widget.child,
                          )
                        : Container(),
                  ],
                ),
                widget.childPosition ==
                        TemtemBaseTechniqueItemChildPosition.bottom
                    ? widget.child
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  formatNumber(int v) {
    if (v < 0) {
      return '-';
    }
    return '$v';
  }

  createText(String key, int v) {
    return Row(
      children: [
        Text(key),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              '${formatNumber(v)}',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
