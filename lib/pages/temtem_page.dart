import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tempedia/models/temtem.dart';
import 'package:tempedia/pages/fragment/temtem_page_base_info_fragment.dart';
import 'package:tempedia/pages/fragment/temtem_page_evolution_fragment.dart';
import 'package:tempedia/pages/fragment/temtem_page_gallery_fragment.dart';
import 'package:tempedia/pages/fragment/temtem_page_location_fragment.dart';
import 'package:tempedia/pages/fragment/temtem_page_stats_fragment.dart';
import 'package:tempedia/pages/fragment/temtem_page_techqniues_fragment.dart';

class TemtemPage extends StatefulWidget {
  final Temtem data;

  const TemtemPage({super.key, required this.data});

  @override
  State<StatefulWidget> createState() => _TemtemPageState();
}

class _TemtemPageState extends State<TemtemPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 6, vsync: this);

    tabController.addListener(() {
      switch (tabController.index) {
        case 0:
          fragmentName = '';
          break;
        case 1:
          fragmentName = '- Stats';
          break;
        case 2:
          fragmentName = '- Techniques';
          break;
        case 3:
          fragmentName = '- Evolution';
          break;
        case 4:
          fragmentName = '- Gallery';
          break;
        default:
          fragmentName = '';
          break;
      }
      setState(() {});
    });
  }

  String fragmentName = '';

  @override
  Widget build(BuildContext context) {
    final data = widget.data;

    return Scaffold(
      appBar: AppBar(
        title: Text('#${data.NO()} ${data.name} $fragmentName'),
        bottom: TabBar(
          controller: tabController,
          // isScrollable: true,
          // physics: const BouncingScrollPhysics(
          //     parent: AlwaysScrollableScrollPhysics()),
          tabs: const [
            Tab(icon: Icon(Icons.catching_pokemon)),
            Tab(icon: Icon(Icons.list)),
            Tab(icon: Icon(FontAwesomeIcons.handFist, size: 18)),
            Tab(icon: Icon(FontAwesomeIcons.dna, size: 18)),
            Tab(icon: Icon(Icons.image)),
            Tab(
              icon: Icon(Icons.location_city),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        // physics: const NeverScrollableScrollPhysics(),
        children: [
          TemtemPageBaseInfoFragment(data: data),
          TemtemPageStatsFragment(stats: data.stats),
          TemtemPageTechniquesFragment(data: data),
          TemtemPageEvolutionFragment(data: data),
          TemtemPageGalleryFragment(
            gallery: data.gallery,
            renders: data.renders,
            subspecies: data.subspecies,
          ),
          TemtemPageLocationFragment(
            data: data,
          ),
        ],
      ),
    );
  }
}
