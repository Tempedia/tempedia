import 'package:flutter/material.dart';
import 'package:tempedia/api/db.dart' as api;
import 'package:tempedia/components/temtem/temtem_type_list_item.dart';
import 'package:tempedia/models/temtem.dart';
import 'package:tempedia/pages/temtem_type_matchup_chart_page.dart';
import 'package:tempedia/utils/transition.dart';

class TemtemTypeListPage extends StatefulWidget {
  const TemtemTypeListPage({super.key});

  @override
  State<StatefulWidget> createState() => _TemtemTypeListPageState();
}

class _TemtemTypeListPageState extends State<TemtemTypeListPage> {
  List<TemtemType> types = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    findTemtemTypes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Type'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                DefaultMaterialPageRoute(
                  builder: (_) => const TemtemTypeMatchupChartPage(),
                ),
              );
            },
            icon: const Icon(Icons.table_chart_outlined),
          )
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        itemCount: types.length,
        itemBuilder: (_, i) => TemtemTypeListItem(data: types[i]),
      ),
    );
  }

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
}
