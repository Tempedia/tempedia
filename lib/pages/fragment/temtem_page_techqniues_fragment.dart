import 'package:flutter/material.dart';
import 'package:tempedia/api/technique.dart' as api;
import 'package:tempedia/components/admob/admob_banner.dart';
import 'package:tempedia/components/html_view.dart';
import 'package:tempedia/components/loading.dart';
import 'package:tempedia/components/managed_expansion_panel_list.dart';
import 'package:tempedia/components/temtem/temtem_breeding_technique_list.dart';
import 'package:tempedia/components/temtem/temtem_course_technique_list.dart';
import 'package:tempedia/components/temtem/temtem_leveling_up_technique_list.dart';
import 'package:tempedia/models/technique.dart';
import 'package:tempedia/models/temtem.dart';

class TemtemPageTechniquesFragment extends StatefulWidget {
  final Temtem data;

  const TemtemPageTechniquesFragment({super.key, required this.data});

  @override
  State<StatefulWidget> createState() => _TemtemPageTechniquesFragmentState();
}

class _TemtemPageTechniquesFragmentState
    extends State<TemtemPageTechniquesFragment>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    findTemtemTechniques();
  }

  @override
  bool get wantKeepAlive => true;

  List<bool> expanded = List.filled(3, false);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      padding: const EdgeInsets.all(10),
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      children: [
        const AdMobBanner(),
        ManagedExpansionPanelList(panels: [
          ManagedExpansionPanelData(
            title: 'By Leveling Up',
            subtitle: 'Techniques learned by leveling up',
            body: loading
                ? const Loading()
                : TemtemLevelingUpTechniquesList(
                    techniques: techGroup?.levelingUp,
                    name: widget.data.name,
                  ),
          ),
          ManagedExpansionPanelData(
            title: 'By Course',
            subtitle: 'Techniques learned from technique course',
            body: loading
                ? const Loading()
                : TemtemCourseTechniquesList(
                    techniques: techGroup?.course,
                    name: widget.data.name,
                  ),
          ),
          ManagedExpansionPanelData(
            title: 'By Breeding',
            subtitle: 'Techniques inherited form parent',
            body: loading
                ? const Loading()
                : Column(
                    children: [
                      TemtemBreedingTechniquesList(
                        techniques: techGroup?.breeding,
                        name: widget.data.name,
                      ),
                      const HtmlView(
                          data:
                              '''<ul><li><small><b>* indicates the parent must learn the technique through a Technique Course.</b></small></li><small>
<li><b>^ indicates the parent must learn the technique through Breeding.</b></li>
<li><b>+ indicates the parent must be bred with a later evolution stage or related evolution due to a type addition/changing/difference.</b></li>
<li><b>- indicates the parent must be bred with an earlier evolution stage due to either a type or their gender ratio changing upon evolution.</b></li>
</small><li><small><b>‡ indicates any variation of the parent can be used.</b></small></li></ul>''')
                    ],
                  ),
          ),
        ]),
        const HtmlView(
            data:
                '''<ul><small><li><b><i>Italic</i> indicates a technique that gets STAB when used by Zaobian.</b></li>
</small><li><small><b>(+ <img alt="unknown" src="https://temtem.wiki.gg/images/thumb/c/c9/UnknownType.png/15px-UnknownType.png" decoding="async" loading="lazy" data-file-width="162" data-file-height="162" width="15" height="15">) indicates the technique has Synergy with the type shown in parentheses.</b></small></li></ul>''')
      ],
    );
  }

  TemtemTechniqueGroup? techGroup;
  bool loading = false;
  findTemtemTechniques() async {
    try {
      setState(() {
        loading = true;
      });
      techGroup = await api.findTemtemTechniquesByTemtem(widget.data.name);
    } finally {
      setState(() {
        loading = false;
      });
    }
  }
}
