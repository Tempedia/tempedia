import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tempedia/api/api.dart';
import 'package:tempedia/api/condition.dart' as api;
import 'package:tempedia/components/loadmore_list_view.dart';
import 'package:tempedia/components/temtem/temtem_status_condition_list_item.dart';

class TemtemStatusConditionListPage extends StatefulWidget {
  const TemtemStatusConditionListPage({super.key});

  @override
  State<StatefulWidget> createState() => _TemtemStatusConditionListPageState();
}

class _TemtemStatusConditionListPageState
    extends State<TemtemStatusConditionListPage> {
  String query = '';
  String queryGroup = '';
  int pageSize = 20;
  final LoadMoreListViewController _controller = LoadMoreListViewController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Status Condition'),
            queryGroup.isNotEmpty
                ? Text(
                    '($queryGroup)',
                  )
                : Container()
          ],
        ),
        actions: [
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
        loader: load,
        itemBuilder: (item, _) => TemtemStatusConditionListItem(data: item),
      ),
    );
  }

  Future<LoadResult?> load(int page) async {
    try {
      final r = await api.findTemtemStatusConditions(
          query: query, group: queryGroup, page: page, pageSize: pageSize);
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
    final oldValue = queryGroup;
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
                        RadioListTile(
                          title: const Text('All'),
                          value: '',
                          groupValue: queryGroup,
                          onChanged: (String? value) {
                            setState(() {
                              queryGroup = value ?? '';
                            });
                          },
                        ),
                        RadioListTile(
                          title: const Text('Negative'),
                          value: 'Negative',
                          groupValue: queryGroup,
                          onChanged: (String? value) {
                            setState(() {
                              queryGroup = value ?? '';
                            });
                          },
                        ),
                        RadioListTile(
                          title: const Text('Positive'),
                          value: 'Positive',
                          groupValue: queryGroup,
                          onChanged: (String? value) {
                            setState(() {
                              queryGroup = value ?? '';
                            });
                          },
                        ),
                        RadioListTile(
                          title: const Text('Neutral'),
                          value: 'Neutral',
                          groupValue: queryGroup,
                          onChanged: (String? value) {
                            setState(() {
                              queryGroup = value ?? '';
                            });
                          },
                        ),
                        RadioListTile(
                          title: const Text('Other'),
                          value: 'Other',
                          groupValue: queryGroup,
                          onChanged: (String? value) {
                            setState(() {
                              queryGroup = value ?? '';
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Close'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        queryGroup = oldValue;
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
