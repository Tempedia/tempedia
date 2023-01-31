import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:tempedia/components/temtem/temtem_type_icon.dart';
import 'package:tempedia/models/temtem.dart';
import 'package:tempedia/api/db.dart' as api;

class TemtemTypeMatchupChartPage extends StatefulWidget {
  const TemtemTypeMatchupChartPage({super.key});

  @override
  State<StatefulWidget> createState() => _TemtemTypeMatchupChartPageState();
}

class _TemtemTypeMatchupChartPageState
    extends State<TemtemTypeMatchupChartPage> {
  List<TemtemType> types = [];

  @override
  void initState() {
    super.initState();
    findTemtemTypes();
  }

  static const double boxSize = 55;

  @override
  Widget build(BuildContext context) {
    List<Widget> headers = [
      const SizedBox(
        width: boxSize,
        height: boxSize,
        child: Center(
          child: Text(
            'A\\D',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    ];
    headers.addAll(types
        .map(
          (e) => SizedBox(
            width: 55,
            height: 55,
            child: Center(
              child: TemtemTypeIcon(
                name: e.name,
                // size: 20,
              ),
            ),
          ),
        )
        .toList());
    return Scaffold(
      appBar: AppBar(title: const Text('Type Chart')),
      body: types.isNotEmpty
          ? HorizontalDataTable(
              scrollPhysics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              horizontalScrollPhysics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              leftHandSideColBackgroundColor: Theme.of(context).cardColor,
              rightHandSideColBackgroundColor: Theme.of(context).cardColor,
              leftHandSideColumnWidth: boxSize,
              rightHandSideColumnWidth: boxSize * (types.length).toDouble(),
              isFixedHeader: true,
              headerWidgets: headers,
              leftSideItemBuilder: (_, i) => SizedBox(
                width: boxSize,
                height: boxSize,
                child: Center(
                  child: TemtemTypeIcon(
                    name: types[i].name,
                    // size: 20,
                  ),
                ),
              ),
              rightSideItemBuilder: (_, i) => buildRow(i),
              itemCount: types.length,
              rowSeparatorWidget: const Divider(
                color: Colors.black54,
                height: 1.0,
                thickness: 1.0,
              ),
            )
          : Container(),
    );
  }

  bool loading = false;
  findTemtemTypes() async {
    try {
      setState(() {
        loading = true;
      });
      types = await api.findTemtemTypesWithDB();
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  Widget buildRow(int i) {
    final attacker = types[i];

    final List<Widget> cols = [];
    for (var t in types) {
      String v = '-';
      Color color = Colors.black;
      if (attacker.effectiveAgainst.contains(t.name)) {
        v = '2';
        color = Colors.green;
      } else if (attacker.ineffectiveAgainst.contains(t.name)) {
        v = '1/2';
        color = Colors.red;
      }
      cols.add(
        SizedBox(
          width: boxSize,
          height: boxSize,
          child: Center(
            child: Text(
              v,
              style: TextStyle(
                  color: color, fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      );
    }
    return Row(
      children: cols,
    );
  }
}
