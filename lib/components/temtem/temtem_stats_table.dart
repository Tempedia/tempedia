import 'package:flutter/material.dart';
import 'package:tempedia/components/colored_progress_bar.dart';
import 'package:tempedia/models/temtem.dart';

class TemtemStatsTable extends StatelessWidget {
  final TemtemStats stats;

  const TemtemStatsTable({super.key, required this.stats});
  static const borderColor = Color(0xffb2738d);

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: borderColor),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {
        0: FlexColumnWidth(),
        1: FixedColumnWidth(140),
      },
      children: <TableRow>[
        TableRow(
          children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.fill,
              child: createHeaderText('Stats'),
            ),
            TableCell(
              child: Table(
                border: const TableBorder(
                  horizontalInside: BorderSide(
                    color: borderColor,
                  ),
                ),
                children: [
                  TableRow(children: [
                    TableCell(
                      child: createHeaderText('Ranges'),
                    ),
                  ]),
                  TableRow(children: [
                    Table(
                      border: const TableBorder(
                        verticalInside: BorderSide(
                          color: borderColor,
                        ),
                      ),
                      children: [
                        TableRow(
                          children: [
                            TableCell(
                              child: createHeaderText('At Lv. 50'),
                            ),
                            TableCell(
                              child: createHeaderText('At Lv. 100'),
                            ),
                          ],
                        )
                      ],
                    )
                  ]),
                ],
              ),
            ),
          ],
        ),
        createStatRow("HP", 'assets/image/25px-StatHP.png', stats.hp.base,
            stats.hp.l50, stats.hp.l100),
        createStatRow("STA", 'assets/image/25px-StatSTA.png', stats.sta.base,
            stats.sta.l50, stats.sta.l100),
        createStatRow("SPD", 'assets/image/25px-StatSPD.png', stats.spd.base,
            stats.spd.l50, stats.spd.l100),
        createStatRow("ATK", 'assets/image/25px-StatATK.png', stats.atk.base,
            stats.atk.l50, stats.atk.l100),
        createStatRow("DEF", 'assets/image/25px-StatDEF.png', stats.def.base,
            stats.def.l50, stats.def.l100),
        createStatRow("SPATK", 'assets/image/25px-StatSPATK.png',
            stats.spatk.base, stats.spatk.l50, stats.spatk.l100),
        createStatRow("SPDEF", 'assets/image/25px-StatSPDEF.png',
            stats.spdef.base, stats.spdef.l50, stats.spdef.l100),
        TableRow(children: [
          TableCell(
            child: Table(
              columnWidths: const {
                0: FixedColumnWidth(105),
                1: FlexColumnWidth(),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              border: const TableBorder(
                verticalInside: BorderSide(
                  color: borderColor,
                ),
              ),
              children: [
                TableRow(children: [
                  TableCell(
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 5, right: 5, top: 2, bottom: 2),
                      alignment: Alignment.centerLeft,
                      decoration: const BoxDecoration(color: Color(0xfffaefd9)),
                      child: Row(
                        children: [
                          const Text(
                            'Total:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              '${stats.hp.base + stats.sta.base + stats.spd.base + stats.atk.base + stats.def.base + stats.spatk.base + stats.spdef.base}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(),
                  ),
                ])
              ],
            ),
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.fill,
            child: Container(
              decoration: const BoxDecoration(color: Color(0xfffaefd9)),
            ),
          ),
        ]),
      ],
    );
  }

  createHeaderText(String text) {
    return Container(
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      alignment: Alignment.center,
      decoration: const BoxDecoration(color: Color(0xFF523351)),
      child: Text(
        text,
        style: const TextStyle(
            color: Color(0xFFfcc56b), fontWeight: FontWeight.bold),
      ),
    );
  }

  createStatText(String text) {
    return Container(
      padding: const EdgeInsets.only(top: 2, bottom: 2),
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  createStatRow(
      String name, String asset, int base, TemtemStatRange l50, l100) {
    return TableRow(
      children: [
        TableCell(
          child: Table(
            columnWidths: const {
              0: FixedColumnWidth(105),
              1: FlexColumnWidth(),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            border: const TableBorder(
              verticalInside: BorderSide(
                color: borderColor,
              ),
            ),
            children: [
              TableRow(children: [
                TableCell(
                  child: Container(
                    decoration: const BoxDecoration(color: Color(0xfffaefd9)),
                    padding: const EdgeInsets.only(
                        left: 5, right: 5, top: 2, bottom: 2),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Image.asset(
                                asset,
                                width: 16,
                                height: 16,
                              ),
                              createStatText('$name:'),
                            ],
                          ),
                        ),
                        createStatText('$base'),
                      ],
                    ),
                  ),
                ),
                TableCell(
                  child: createProgressBar(base),
                ),
              ])
            ],
          ),
        ),
        TableCell(
          child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            border: const TableBorder(
              verticalInside: BorderSide(
                color: borderColor,
              ),
            ),
            children: [
              TableRow(children: [
                TableCell(
                  child: Container(
                    decoration: const BoxDecoration(color: Color(0xfffaefd9)),
                    child: createStatText('${l50.from} - ${l50.to}'),
                  ),
                ),
                TableCell(
                  child: Container(
                    decoration: const BoxDecoration(color: Color(0xfffaefd9)),
                    child: createStatText('${l100.from} - ${l100.to}'),
                  ),
                ),
              ])
            ],
          ),
        ),
      ],
    );
  }

  createProgressBar(int base) {
    return Container(
      padding: const EdgeInsets.only(left: 4, right: 4),
      child: ColoredProgressBar(
        value: base.toDouble(),
        begin: const Color(0xFFFF2B00),
        end: const Color(0xFF14FF00),
        max: 110,
        duration: const Duration(milliseconds: 600),
      ),
    );
  }
}
