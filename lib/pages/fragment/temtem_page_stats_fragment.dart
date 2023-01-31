import 'package:flutter/material.dart';
import 'package:tempedia/components/admob/admob_banner.dart';
import 'package:tempedia/components/radar_chart.dart';
import 'package:tempedia/components/temtem/temtem_stats_table.dart';
import 'package:tempedia/models/temtem.dart';

class TemtemPageStatsFragment extends StatelessWidget {
  final TemtemStats stats;

  const TemtemPageStatsFragment({
    super.key,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    final radarData = <num>[];
    radarData.add(stats.hp.base);
    radarData.add(stats.sta.base);
    radarData.add(stats.spd.base);
    radarData.add(stats.atk.base);
    radarData.add(stats.def.base);
    radarData.add(stats.spatk.base);
    radarData.add(stats.spdef.base);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const AdMobBanner(),
            Container(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: AspectRatio(
                aspectRatio: 1,
                child: RadarChart(
                  max: 110,
                  labels: const [
                    'HP',
                    'STA',
                    'SPD',
                    'ATK',
                    'DEF',
                    'SPATK',
                    'SPDEF'
                  ],
                  data: radarData,
                  duration: const Duration(milliseconds: 600),
                ),
              ),
            ),
            TemtemStatsTable(stats: stats),
          ],
        ),
      ),
    );
  }
}
