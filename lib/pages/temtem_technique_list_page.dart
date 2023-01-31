import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tempedia/api/api.dart';
import 'package:tempedia/api/technique.dart' as api;
import 'package:tempedia/components/divider_with_text.dart';
import 'package:tempedia/components/loadmore_list_view.dart';
import 'package:tempedia/components/temtem/temtem_base_technique_item.dart';
import 'package:tempedia/components/temtem/temtem_technique_class_icon.dart';
import 'package:tempedia/components/temtem/temtem_technique_class_toggle_buttons.dart';
import 'package:tempedia/components/temtem/temtem_type_icon.dart';
import 'package:tempedia/components/temtem/temtem_type_toggle_buttons.dart';
import 'package:tempedia/models/technique.dart';
import 'package:tempedia/pages/temtem_technique_course_list_page.dart';
import 'package:tempedia/utils/transition.dart';

class TemtemTechniqueListPage extends StatefulWidget {
  const TemtemTechniqueListPage({super.key});

  @override
  State<StatefulWidget> createState() => _TemtemTechniqueListPageState();
}

class _TemtemTechniqueListPageState extends State<TemtemTechniqueListPage> {
  String query = '';
  List<String> queryTypes = [];
  String queryClass = '';
  int pageSize = 20;

  @override
  void initState() {
    super.initState();
  }

  final LoadMoreListViewController _controller = LoadMoreListViewController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Technique'),
            Row(
              children: queryTypes
                  .map((e) => TemtemTypeIcon(
                        name: e,
                        size: 24,
                      ))
                  .toList(),
            ),
            queryClass.isNotEmpty
                ? TemtemTechniqueClassIcon(cls: queryClass)
                : Container(),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                DefaultMaterialPageRoute(
                  builder: (context) => const TemtemTechniqueCourseListPage(),
                ),
              );
            },
            icon: const Icon(Icons.school),
          ),
          IconButton(
            onPressed: showTemtemTypesDialog,
            icon: const Icon(
              FontAwesomeIcons.filter,
              size: 20,
            ),
          ),
        ],
      ),
      body: LoadMoreListView(
        controller: _controller,
        itemBuilder: (item, i) => TemtemBaseTechniqueItem(
          data: TemtemTechqniueBase(stab: false, technique: item),
          child: Container(),
        ),
        loader: load,
      ),
    );
  }

  Future<LoadResult?> load(int page) async {
    try {
      final r = await api.findTemtemTechniques(
        query: query,
        page: page,
        pageSize: pageSize,
        types: queryTypes,
        cls: queryClass,
      );
      return LoadResult(list: r.list, hasMore: r.list.length >= pageSize);
    } on ApiException {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unknown Error'),
        ),
      );
    }
    return null;
  }

  showTemtemTypesDialog() {
    final oldValues = List<String>.from(queryTypes);
    showDialog(
      context: context,
      builder: ((context) => StatefulBuilder(
            builder: ((context, setState) => AlertDialog(
                  title: const Text('Filter'),
                  content: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    child: Column(
                      children: [
                        const DividerWithText(text: 'Type'),
                        TemtemTypeToggleButtons(
                          size: TemtemTypeToggleItemSize.small,
                          onSelected: (values) {
                            queryTypes = values;
                            setState(() {});
                          },
                          selected: queryTypes,
                        ),
                        const DividerWithText(text: 'Class'),
                        TemtemTechniqueClassToggleButtons(
                          onSelected: (values) {
                            queryClass = values.isNotEmpty ? values[0] : '';
                            setState(() {});
                          },
                          selected: queryClass.isNotEmpty ? [queryClass] : [],
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Close'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        queryTypes = oldValues;
                        setState(() {});
                      },
                    ),
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        _controller.reset();
                        this.setState(() {});
                      },
                    ),
                  ],
                )),
          )),
    );
  }
}
