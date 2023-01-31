import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tempedia/api/file.dart';
import 'package:tempedia/components/admob/admob_banner.dart';
import 'package:tempedia/components/html_view.dart';
import 'package:tempedia/components/managed_expansion_panel_list.dart';
import 'package:tempedia/components/temtem/temtem_status_condition_technique_list.dart';
import 'package:tempedia/components/temtem/temtem_status_condition_trait_list.dart';
import 'package:tempedia/models/condition.dart';

class TemtemStatusConditionPage extends StatefulWidget {
  final TemtemStatusCondition data;
  const TemtemStatusConditionPage({super.key, required this.data});

  @override
  State<StatefulWidget> createState() => _TemtemStatusConditionPageState();
}

class _TemtemStatusConditionPageState extends State<TemtemStatusConditionPage> {
  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CachedNetworkImage(imageUrl: fileurl(data.icon)),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Text(data.name),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        children: [
          const AdMobBanner(),
          HtmlView(data: '<i>${data.description}</i>'),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: ManagedExpansionPanelList(panels: [
              ManagedExpansionPanelData(
                title: 'Techniques',
                subtitle: 'techniques inflicting the Asleep condition. ',
                body: TemtemStatusConditionTechniqueList(condition: data),
              ),
              ManagedExpansionPanelData(
                title: 'Traits',
                subtitle: 'traits inflicting the Asleep condition.',
                body: TemtemStatusConditionTraitList(condition: data),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
