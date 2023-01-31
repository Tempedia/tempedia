import 'package:flutter/material.dart';
import 'package:tempedia/components/temtem/temtem_type_icon.dart';
import 'package:tempedia/components/temtem/temtem_type_matchup.dart';
import 'package:tempedia/models/temtem.dart';

class TemtemTypeMatchupPage extends StatefulWidget {
  final Temtem data;

  const TemtemTypeMatchupPage({super.key, required this.data});
  @override
  State<StatefulWidget> createState() => _TemtemTypeMatchupPageState();
}

class _TemtemTypeMatchupPageState extends State<TemtemTypeMatchupPage> {
  @override
  void initState() {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeRight,
    //   DeviceOrientation.landscapeLeft,
    // ]);
    super.initState();
  }

  @override
  dispose() {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeRight,
    //   DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;

    List<String> groups = [];
    Map<String, List<Map<String, dynamic>>> groupMatchups = {};
    for (var matchup in data.typeMatchup) {
      final g = matchup['group'] ?? '';
      if (g.isNotEmpty) {
        if (!groups.contains(g)) {
          groups.add(g);
        }
        groupMatchups[g] = groupMatchups[g] ?? [];
        groupMatchups[g]!.add(matchup);
      }
    }

    final title = Row(
      children: [const Text('Type Matchup')],
    );
    title.children.addAll(
      data.type.map((e) => TemtemTypeIcon(name: e)).toList(),
    );
    if (groups.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: title,
        ),
        body: CustomScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: TemtemTypeMatchupTable(matchups: data.typeMatchup),
            ),
          ],
        ),
      );
    }

    return DefaultTabController(
      length: groups.length,
      child: Scaffold(
        appBar: AppBar(
          title: title,
          bottom: TabBar(
            isScrollable: true,
            tabs: groups
                .map((e) => Tab(
                      text: e,
                    ))
                .toList(),
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: groups
              .map(
                (e) => CustomScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: TemtemTypeMatchupTable(
                          matchups: groupMatchups[e] ?? []),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
