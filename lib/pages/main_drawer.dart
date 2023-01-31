import 'package:flutter/material.dart';
import 'package:tempedia/pages/about_page.dart';
import 'package:tempedia/pages/team/team_list_page.dart';
import 'package:tempedia/pages/settings_page.dart';
import 'package:tempedia/pages/temtem_location_list_page.dart';
import 'package:tempedia/pages/temtem_status_condition_list_page.dart';
import 'package:tempedia/pages/temtem_technique_list_page.dart';
import 'package:tempedia/pages/temtem_trait_list_page.dart';
import 'package:tempedia/pages/temtem_type_list_page.dart';
import 'package:tempedia/utils/transition.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({super.key});

  @override
  State<StatefulWidget> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // backgroundColor: Theme.of(context).primaryColor,
      child: ListView(
        padding: EdgeInsets.zero,
        // physics: const BouncingScrollPhysics(
        //     parent: AlwaysScrollableScrollPhysics()),
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Container(),
          ),
          ListTile(
            leading: Image.asset(
              'assets/image/Neutral.png',
              width: 36,
            ),
            title: const Text('Type'),
            onTap: () {
              Navigator.push(
                context,
                DefaultMaterialPageRoute(
                    builder: (_) => const TemtemTypeListPage()),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              'assets/image/Key_Item_Marker_Icon.png',
              width: 32,
            ),
            title: const Text('Trait'),
            onTap: () {
              Navigator.push(
                  context,
                  DefaultMaterialPageRoute(
                      builder: (_) => const TemtemTraitListPage()));
            },
          ),
          ListTile(
            leading: Image.asset(
              'assets/image/Physical.png',
              width: 32,
            ),
            title: const Text('Technique'),
            onTap: () {
              Navigator.push(
                  context,
                  DefaultMaterialPageRoute(
                      builder: (_) => const TemtemTechniqueListPage()));
            },
          ),
          ListTile(
            leading: Image.asset(
              'assets/image/Landmarks-Towns_Marker_Icon.png',
              width: 32,
            ),
            title: const Text('Location'),
            onTap: () {
              Navigator.push(
                context,
                DefaultMaterialPageRoute(
                    builder: (context) => const TemtemLocationListPage()),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              'assets/image/Nullified.png',
              width: 32,
            ),
            title: const Text('Condition'),
            onTap: () {
              Navigator.push(
                context,
                DefaultMaterialPageRoute(
                    builder: (context) =>
                        const TemtemStatusConditionListPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.catching_pokemon,
              color: Theme.of(context).iconTheme.color,
              size: 32,
            ),
            title: const Text('My Teams'),
            onTap: () {
              Navigator.push(
                context,
                DefaultMaterialPageRoute(
                  builder: (context) => const TeamListPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Theme.of(context).iconTheme.color,
              size: 32,
            ),
            title: const Text('Settings'),
            onTap: () {
              Navigator.push(
                context,
                DefaultMaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
