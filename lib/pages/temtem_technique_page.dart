import 'package:flutter/material.dart';
import 'package:tempedia/models/technique.dart';
import 'package:tempedia/pages/fragment/temtem_technique_page_detail_fragment.dart';
import 'package:tempedia/pages/fragment/temtem_technique_page_temtem_fragment.dart';

class TemtemTechniquePage extends StatefulWidget {
  final TemtemTechnique data;

  const TemtemTechniquePage({super.key, required this.data});

  @override
  State<StatefulWidget> createState() => _TemtemTechniquePageState();
}

class _TemtemTechniquePageState extends State<TemtemTechniquePage>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    return Scaffold(
      appBar: AppBar(
        title: Text('Technique - ${data.name}'),
        bottom: TabBar(
          controller: tabController,
          tabs: const [
            Tab(icon: Icon(Icons.details)),
            Tab(
              icon: Icon(Icons.catching_pokemon),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        // physics: const NeverScrollableScrollPhysics(),
        children: [
          TemtemTechniquePageDetailFragment(data: data),
          TemtemTechniquePageTemtemFragment(data: data),
        ],
      ),
    );
  }
}
