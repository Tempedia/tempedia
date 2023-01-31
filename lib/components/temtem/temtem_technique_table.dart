import 'package:flutter/material.dart';
import 'package:tempedia/components/divider_with_text.dart';
import 'package:tempedia/components/html_view.dart';
import 'package:tempedia/components/temtem/temtem_technique_class_icon.dart';
import 'package:tempedia/components/temtem/temtem_technique_priority_icon.dart';
import 'package:tempedia/components/temtem/temtem_type_icon.dart';
import 'package:tempedia/models/technique.dart';

_createTextValue(String v) {
  return Container(
    padding: const EdgeInsets.only(top: 4, bottom: 4, left: 2),
    child: Text(
      v,
    ),
  );
}

_formatNumber(int v) {
  if (v < 0) {
    return '-';
  }
  return '$v';
}

class TemtemTechniqueTable extends StatelessWidget {
  final TemtemTechnique data;
  const TemtemTechniqueTable({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {
        0: FixedColumnWidth(100),
        1: IntrinsicColumnWidth(flex: 1),
      },
      children: [
        TableRow(
          children: [
            TableCell(
              child: _createTextValue('Type'),
            ),
            TableCell(
                child: Row(
              children: [
                TemtemTypeIcon(
                  name: data.type,
                  size: 28,
                ),
                Text(data.type)
              ],
            ))
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child: _createTextValue('Class'),
            ),
            TableCell(
                child: Row(
              children: [
                TemtemTechniqueClassIcon(
                  cls: data.cls,
                  size: 24,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 2),
                  child: Text(data.cls),
                ),
              ],
            ))
          ],
        ),
        TableRow(children: [
          TableCell(child: _createTextValue('Damage')),
          TableCell(child: _createTextValue('${_formatNumber(data.damage)}')),
        ]),
        TableRow(children: [
          TableCell(child: _createTextValue('STA Cost')),
          TableCell(child: _createTextValue('${_formatNumber(data.staCost)}')),
        ]),
        TableRow(children: [
          TableCell(child: _createTextValue('Hold')),
          TableCell(child: _createTextValue('${_formatNumber(data.hold)}')),
        ]),
        TableRow(children: [
          TableCell(child: _createTextValue('Priority')),
          TableCell(
            child: Container(
              alignment: Alignment.centerLeft,
              child: TemtemTechniquePriorityIcon(
                priority: data.priority,
                size: 24,
              ),
            ),
          ),
        ]),
        TableRow(children: [
          TableCell(child: _createTextValue('Targeting')),
          TableCell(
            child: _createTextValue(data.targeting),
          ),
        ]),
      ],
    );
  }
}

class TemtemTechniqueSynergyTable extends StatelessWidget {
  final TemtemTechnique data;
  const TemtemTechniqueSynergyTable({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    List<TableRow> rows = [
      TableRow(
        children: [
          TableCell(
            child: _createTextValue('Synergy'),
          ),
          TableCell(
              child: Row(
            children: [
              TemtemTypeIcon(
                name: data.synergyType,
                size: 28,
              ),
              Text(data.synergyType)
            ],
          ))
        ],
      )
    ];
    if (data.synergyDamage >= 0) {
      rows.add(TableRow(children: [
        TableCell(child: _createTextValue('Damage')),
        TableCell(
            child: _createTextValue('${_formatNumber(data.synergyDamage)}')),
      ]));
    }
    if (data.synergySTACost >= 0) {
      rows.add(TableRow(children: [
        TableCell(child: _createTextValue('STA Cost')),
        TableCell(
            child: _createTextValue('${_formatNumber(data.synergySTACost)}')),
      ]));
    }
    if (data.synergyPriority >= 0) {
      rows.add(TableRow(children: [
        TableCell(child: _createTextValue('Priority')),
        TableCell(
          child: Container(
            alignment: Alignment.centerLeft,
            child: TemtemTechniquePriorityIcon(
              priority: data.synergyPriority,
              size: 24,
            ),
          ),
        ),
      ]));
    }
    if (data.synergyTargeting.isNotEmpty) {
      rows.add(TableRow(children: [
        TableCell(child: _createTextValue('Targeting')),
        TableCell(
          child: _createTextValue(data.synergyTargeting),
        ),
      ]));
    }
    if (data.synergyEffects.isNotEmpty) {
      rows.add(TableRow(children: [
        TableCell(child: _createTextValue('Effects')),
        TableCell(
          child: HtmlView(data: data.synergyEffects),
        ),
      ]));
    }
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {
        0: FixedColumnWidth(100),
        1: IntrinsicColumnWidth(flex: 1),
      },
      children: rows,
    );
  }
}
