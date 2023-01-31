import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tempedia/api/api.dart';
import 'package:tempedia/api/temtem.dart' as api;
import 'package:tempedia/components/loadmore_list_view.dart';
import 'package:tempedia/components/temtem/temtem_list_item.dart';
import 'package:tempedia/components/temtem/temtem_type_icon.dart';
import 'package:tempedia/components/temtem/temtem_type_toggle_buttons.dart';
import 'package:tempedia/models/temtem.dart';
import 'package:tempedia/pages/main_drawer.dart';
import 'package:tempedia/pages/temtem_page.dart';
import 'package:tempedia/components/temtem/temtem_general_search_delegate.dart';
import 'package:tempedia/utils/transition.dart';

class TemtemListPage extends StatefulWidget {
  const TemtemListPage({super.key});

  @override
  State<StatefulWidget> createState() => TemtemListPageState();
}

class TemtemListPageState extends State<TemtemListPage> {
  @override
  void initState() {
    super.initState();
  }

  String query = '';
  List<String> queryTypes = [];
  int pageSize = 99;
  final LoadMoreListViewController _controller = LoadMoreListViewController();

  Future<LoadResult?> findTemtems(int page) async {
    try {
      final r = await api.findTemtems(
        query: query,
        types: queryTypes,
        trait: '',
        page: page,
        pageSize: pageSize,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Temtem'),
            Row(
              children: queryTypes
                  .map(
                    (e) => TemtemTypeIcon(
                      name: e,
                      size: 24,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                  context: context, delegate: TemtemGeneralSearchDelegate());
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: showFilterDialog,
            icon: const Icon(
              FontAwesomeIcons.filter,
              size: 20,
            ),
          ),
        ],
      ),
      drawer: const MainDrawer(),
      body: LoadMoreListView(
        controller: _controller,
        itemBuilder: (item, i) => TemtemListItem(
          data: item as Temtem,
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRouteWithFadeTransition(
                builder: (context) => TemtemPage(
                  data: item,
                ),
              ),
            )
          },
        ),
        loader: findTemtems,
      ),
    );
  }

  showFilterDialog() {
    final oldValues = List<String>.from(queryTypes);
    showDialog(
      context: context,
      builder: ((context) => StatefulBuilder(
            builder: ((context, setState) => AlertDialog(
                  title: const Text('Filter'),
                  content: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    child: TemtemTypeToggleButtons(
                      onSelected: (values) {
                        queryTypes = values;
                        setState(() {});
                      },
                      selected: queryTypes,
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
