import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tempedia/api/api.dart';
import 'package:tempedia/components/loadmore_list_view.dart';
import 'package:tempedia/api/temtem.dart' as api;
import 'package:tempedia/components/team/team_temtem_select_list_item.dart';
import 'package:tempedia/components/team/temtem_search_delegate.dart';
import 'package:tempedia/components/temtem/temtem_type_toggle_buttons.dart';
import 'package:tempedia/models/temtem.dart';
import 'package:tempedia/pages/team/team_temtem_subspecie_select_page.dart';
import 'package:tempedia/utils/transition.dart';

class TeamTemtemSelectPage extends StatefulWidget {
  const TeamTemtemSelectPage({super.key});

  @override
  State<StatefulWidget> createState() => _TeamTemtemSelectPageState();
}

class _TeamTemtemSelectPageState extends State<TeamTemtemSelectPage> {
  final LoadMoreListViewController _controller = LoadMoreListViewController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Temtem'),
        actions: [
          IconButton(
            onPressed: () async {
              final data = await showSearch(
                context: context,
                delegate: TemtemSearchDelegate(),
              );
              if (data != null) {
                select(data);
              }
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
      body: LoadMoreListView(
        controller: _controller,
        itemBuilder: (item, i) => TeamTemtemSelectListItem(
          data: item as Temtem,
          onTap: () => select(item),
        ),
        loader: findTemtems,
      ),
    );
  }

  String query = '';
  List<String> queryTypes = [];
  int pageSize = 50;

  Future<LoadResult?> findTemtems(int page) async {
    try {
      final r = await api.findTemtems(
        query: query,
        types: queryTypes,
        trait: '',
        page: page,
        pageSize: pageSize,
        withTechnique: true,
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

  select(Temtem data) async {
    if (data.subspecies.isNotEmpty) {
      /* 选择分支 */
      final r = await Navigator.push(
        context,
        DefaultMaterialPageRoute(
          builder: (context) => TeamTemtemSubspecieSelectPage(data: data),
        ),
      );
      if (r != null) {
        Navigator.pop(context, r);
      }
    } else {
      /* 返回 */
      Navigator.pop(context, data);
    }
  }
}
