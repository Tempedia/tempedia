import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';
import 'package:tempedia/api/db.dart';
import 'package:tempedia/api/file.dart';
import 'package:tempedia/models/temtem.dart';

class TemtemTypeMatchupTable extends StatefulWidget {
  final List<Map<String, dynamic>> matchups;
  const TemtemTypeMatchupTable({super.key, required this.matchups});

  @override
  State<StatefulWidget> createState() => TemtemTypeMatchupTableState();
}

class TemtemTypeMatchupTableState extends State<TemtemTypeMatchupTable> {
  List<TemtemType> types = [];

  @override
  void initState() {
    super.initState();

    findTemtemTypes();
  }

  findTemtemTypes() async {
    try {
      types = await findTemtemTypesWithDB();
      setState(() {});
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    if (types.isEmpty) {
      return Container();
    }

    final List<Widget> headers = [];
    var withName = false;
    if (widget.matchups.isNotEmpty &&
        widget.matchups[0]['name'] is String &&
        widget.matchups[0]['name'].isNotEmpty) {
      headers.add(
        const TableCell(
          child: Text(
            'Trait',
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      );
      withName = true;
    }
    headers.addAll(
      types
          .map(
            (e) => TableCell(
              child: Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                child: CachedNetworkImage(
                  imageUrl: fileurl(e.icon),
                  width: 26,
                  height: 26,
                ),
              ),
            ),
          )
          .toList(),
    );
    final rows = [
      TableRow(
        children: headers,
      ),
    ];
    for (var matchup in widget.matchups) {
      final List<TableCell> cols = [];
      if (withName) {
        cols.add(
          TableCell(
            child: Container(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Text(
                matchup['name'] ?? '',
                style: const TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      }
      for (var type in types) {
        double v = (matchup[type.name] ?? 1).toDouble();
        cols.add(createTableCell(v));
      }

      rows.add(TableRow(children: cols));
    }
    return Table(
      columnWidths: withName
          ? const {
              0: IntrinsicColumnWidth(flex: 2),
            }
          : {},
      defaultColumnWidth: const IntrinsicColumnWidth(flex: 1),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      border: TableBorder.all(
        color: Colors.grey.shade400,
      ),
      children: rows,
    );
  }

  createTableCell(double v) {
    String text = '-';
    Color color = Theme.of(context).cardColor;
    if (v != 1) {
      text = sprintf('%g', [v]);
    }
    if (v == 0) {
      color = const Color(0xFFFF0000);
    } else if (v == 0.25) {
      color = const Color(0xFFFF9966);
      text = '1/4';
    } else if (v == 0.5) {
      color = const Color(0xFFFFFFAA);
      text = '1/2';
    } else if (v == 2) {
      color = const Color(0xFFAAFFAA);
    } else if (v == 4) {
      color = const Color(0xFF66BB66);
    }
    return TableCell(
      child: Container(
        // padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
        width: 36,
        height: 36,
        alignment: Alignment.center,
        color: color,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
