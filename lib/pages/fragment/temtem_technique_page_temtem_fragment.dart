import 'package:flutter/material.dart';
import 'package:tempedia/api/api.dart';
import 'package:tempedia/api/technique.dart' as api;
import 'package:tempedia/components/admob/admob_banner.dart';
import 'package:tempedia/components/html_view.dart';
import 'package:tempedia/components/loading.dart';
import 'package:tempedia/components/managed_expansion_panel_list.dart';
import 'package:tempedia/components/temtem/temtem_technique_breeding_temtem_list.dart';
import 'package:tempedia/components/temtem/temtem_technique_course_temtem_list.dart';
import 'package:tempedia/components/temtem/temtem_technique_leveling_up_temtem_list.dart';
import 'package:tempedia/models/technique.dart';

class TemtemTechniquePageTemtemFragment extends StatefulWidget {
  final TemtemTechnique data;
  const TemtemTechniquePageTemtemFragment({super.key, required this.data});

  @override
  State<StatefulWidget> createState() =>
      _TemtemTechniquePageTemtemFragmentState();
}

class _TemtemTechniquePageTemtemFragmentState
    extends State<TemtemTechniquePageTemtemFragment>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    findTemtems();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      padding: const EdgeInsets.all(10),
      children: [
        const AdMobBanner(),
        ManagedExpansionPanelList(panels: [
          ManagedExpansionPanelData(
            title: 'Level up',
            subtitle: 'Temtems that learn by leveling up',
            body: loading
                ? const Loading()
                : TemtemTechniqueLevelingUpTemtemList(
                    temtems: levelingUp,
                  ),
          ),
          ManagedExpansionPanelData(
            title: 'Technique Course',
            subtitle: 'Temtems that learn by technique course',
            body: loading
                ? const Loading()
                : TemtemTechniqueCourseTemtemList(
                    temtems: course,
                  ),
          ),
          ManagedExpansionPanelData(
            title: 'Breeding',
            subtitle: 'Temtems that learn by breeding',
            body: Column(
              children: [
                loading
                    ? const Loading()
                    : TemtemTechniqueBreedingTemtemList(
                        temtems: breeding,
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
      ],
    );
  }

  bool loading = false;
  List<TemtemLevelingUpTechnique> levelingUp = [];
  List<TemtemCourseTechnique> course = [];
  List<TemtemBreedingTechnique> breeding = [];
  findTemtems() async {
    try {
      setState(() {
        loading = true;
      });
      final r = await api.findTemtemsByTechnique(widget.data.name);
      levelingUp = r.levelingUp;
      course = r.course;
      breeding = r.breeding;
    } on ApiException {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unknown Error'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Network Error'),
        ),
      );
      print(e);
    } finally {
      setState(() {
        loading = false;
      });
    }
  }
}
