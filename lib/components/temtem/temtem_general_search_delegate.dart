import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:tempedia/api/file.dart';
import 'package:tempedia/api/search.dart' as api;
import 'package:tempedia/components/divider_with_text.dart';
import 'package:tempedia/components/loading.dart';
import 'package:tempedia/components/temtem/temtem_icon.dart';
import 'package:tempedia/components/temtem/temtem_technique_synergy_icon.dart';
import 'package:tempedia/components/temtem/temtem_type_icon.dart';
import 'package:tempedia/models/condition.dart';
import 'package:tempedia/models/location.dart';
import 'package:tempedia/models/technique.dart';
import 'package:tempedia/models/temtem.dart';
import 'package:tempedia/models/trait.dart';
import 'package:tempedia/pages/temtem_location_page.dart';
import 'package:tempedia/pages/temtem_page.dart';
import 'package:tempedia/pages/temtem_status_condition_page.dart';
import 'package:tempedia/pages/temtem_technique_page.dart';
import 'package:tempedia/pages/temtem_trait_page.dart';
import 'package:tempedia/utils/transition.dart';

class TemtemGeneralSearchDelegate extends SearchDelegate {
// first overwrite to
// clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

// second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

// third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

// last overwrite to show the
// querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: search(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (!snapshot.hasData) {
            return Container();
          }
          final data = snapshot.data as api.SearchResult;
          final List<String> sections = [];
          if (data.temtems.isNotEmpty) {
            sections.add('Temtems');
          }
          if (data.techniques.isNotEmpty) {
            sections.add('Techniques');
          }
          if (data.traits.isNotEmpty) {
            sections.add('Traits');
          }
          if (data.locations.isNotEmpty) {
            sections.add('Locations');
          }
          if (data.conditions.isNotEmpty) {
            sections.add('Conditions');
          }
          return GroupListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            itemBuilder: (context, index) {
              final section = sections[index.section];
              String name = '';
              switch (section) {
                case 'Temtems':
                  return TemtemSearchTemtemItem(
                    data: data.temtems[index.index],
                  );
                case 'Techniques':
                  return _TemtemSearchTechniqueItem(
                    data: data.techniques[index.index],
                  );
                case 'Traits':
                  return _TemtemSearchTraitItem(
                    data: data.traits[index.index],
                  );
                case 'Locations':
                  return _TemtemSearchLocationItem(
                    data: data.locations[index.index],
                  );
                case 'Conditions':
                  return _TemtemSearchConditionItem(
                    data: data.conditions[index.index],
                  );
              }
              return ListTile(
                title: Text(name),
                onTap: () {},
              );
            },
            sectionsCount: sections.length,
            groupHeaderBuilder: (_, i) {
              return DividerWithText(text: sections[i]);
            },
            countOfItemInSection: (i) {
              final section = sections[i];
              switch (section) {
                case 'Temtems':
                  return data.temtems.length;
                case 'Techniques':
                  return data.techniques.length;
                case 'Traits':
                  return data.traits.length;
                case 'Locations':
                  return data.locations.length;
                case 'Conditions':
                  return data.conditions.length;
              }
              return 0;
            },
          );
        } else {
          return const Loading();
        }
      },
    );
  }

  Future<api.SearchResult?>? search(String q) async {
    try {
      return api.search(q);
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Network Error",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
    return null;
  }
}

class TemtemSearchTemtemItem extends StatelessWidget {
  final Temtem data;
  final Function? onTap;

  const TemtemSearchTemtemItem({super.key, required this.data, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: TemtemIcon(
        fileid: data.icon,
        size: 40,
      ),
      title: Text(data.name),
      subtitle: Text('#${data.NO()}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: data.type
            .map((e) => TemtemTypeIcon(
                  name: e,
                  size: 22,
                ))
            .toList(),
      ),
      onTap: () {
        if (onTap != null) {
          onTap!();
          return;
        }
        Navigator.push(
          context,
          DefaultMaterialPageRoute(
            builder: (context) => TemtemPage(data: data),
          ),
        );
      },
    );
  }
}

class _TemtemSearchTechniqueItem extends StatelessWidget {
  final TemtemTechnique data;

  const _TemtemSearchTechniqueItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TemtemTypeIcon(name: data.type),
          TemtemTechniqueSynergyIcon(type: data.synergyType),
        ],
      ),
      title: Text(data.name),
      onTap: () {
        Navigator.push(
          context,
          DefaultMaterialPageRoute(
            builder: (context) => TemtemTechniquePage(data: data),
          ),
        );
      },
    );
  }
}

class _TemtemSearchTraitItem extends StatelessWidget {
  final TemtemTrait data;

  const _TemtemSearchTraitItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(data.name),
      subtitle: Text(data.effect),
      onTap: () {
        Navigator.push(
          context,
          DefaultMaterialPageRoute(
            builder: (context) => TemtemTraitPage(name: data.name, data: data),
          ),
        );
      },
    );
  }
}

class _TemtemSearchLocationItem extends StatelessWidget {
  final TemtemLocation data;
  const _TemtemSearchLocationItem({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: CachedNetworkImage(
        imageUrl: fileurl(data.image),
        width: 40,
        height: 40,
        fit: BoxFit.contain,
      ),
      title: Text(data.name),
      subtitle: Text(
        data.comment,
        style: const TextStyle(overflow: TextOverflow.ellipsis),
      ),
      onTap: () {
        Navigator.push(
          context,
          DefaultMaterialPageRoute(
            builder: (context) => TemtemLocationPage(data: data),
          ),
        );
      },
    );
  }
}

class _TemtemSearchConditionItem extends StatelessWidget {
  final TemtemStatusCondition data;

  const _TemtemSearchConditionItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(data.name),
      subtitle: Text(data.group),
      leading: CachedNetworkImage(
        imageUrl: fileurl(data.icon),
        width: 25,
        height: 25,
        fit: BoxFit.contain,
      ),
      onTap: () {
        Navigator.push(
          context,
          DefaultMaterialPageRoute(
            builder: (context) => TemtemStatusConditionPage(data: data),
          ),
        );
      },
    );
  }
}
