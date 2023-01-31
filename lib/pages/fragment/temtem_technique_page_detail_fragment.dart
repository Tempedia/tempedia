import 'package:flutter/material.dart';
import 'package:tempedia/components/admob/admob_banner.dart';
import 'package:tempedia/components/divider_with_text.dart';
import 'package:tempedia/components/html_view.dart';
import 'package:tempedia/components/network_video_palyer.dart';
import 'package:tempedia/components/temtem/temtem_technique_class_icon.dart';
import 'package:tempedia/components/temtem/temtem_technique_priority_icon.dart';
import 'package:tempedia/components/temtem/temtem_technique_table.dart';
import 'package:tempedia/components/temtem/temtem_type_icon.dart';
import 'package:tempedia/models/technique.dart';

class TemtemTechniquePageDetailFragment extends StatefulWidget {
  final TemtemTechnique data;

  const TemtemTechniquePageDetailFragment({super.key, required this.data});

  @override
  State<StatefulWidget> createState() =>
      _TemtemTechniquePageDetailFragmentState();
}

class _TemtemTechniquePageDetailFragmentState
    extends State<TemtemTechniquePageDetailFragment>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final data = widget.data;

    return ListView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      padding: const EdgeInsets.all(10),
      children: [
        const AdMobBanner(),
        Text(
          data.name,
          style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w500),
        ),
        HtmlView(data: '<i>${data.description}</i>'),
        TemtemTechniqueTable(data: data),
        NetworkVideoPlayer(url: data.video),
        data.synergyType.isNotEmpty ? buildSynergy() : Container(),
      ],
    );
  }

  buildSynergy() {
    final data = widget.data;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DividerWithText(text: 'Synergy Details'),
        HtmlView(data: '<i>${data.synergyDescription}</i>'),
        TemtemTechniqueSynergyTable(data: data),
        NetworkVideoPlayer(url: data.synergyVideo),
      ],
    );
  }
}
