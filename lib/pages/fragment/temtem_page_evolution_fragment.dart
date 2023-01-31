import 'package:flutter/material.dart';
import 'package:tempedia/components/admob/admob_banner.dart';
import 'package:tempedia/components/temtem/temtem_evolution_to.dart';
import 'package:tempedia/models/temtem.dart';

class TemtemPageEvolutionFragment extends StatefulWidget {
  final Temtem data;
  const TemtemPageEvolutionFragment({super.key, required this.data});

  @override
  State<StatefulWidget> createState() => _TemtemPageEvolutionFragmentState();
}

class _TemtemPageEvolutionFragmentState
    extends State<TemtemPageEvolutionFragment>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final data = widget.data;
    return SingleChildScrollView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const AdMobBanner(),
            TemtemEvolutionTo(
              data: data,
              from: true,
            ),
          ],
        ),
      ),
    );
  }
}
