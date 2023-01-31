import 'package:flutter/material.dart';
import 'package:tempedia/api/api.dart';
import 'package:tempedia/api/location.dart' as api;
import 'package:tempedia/components/loadmore_list_view.dart';
import 'package:tempedia/components/temtem/temtem_location_list_item.dart';
import 'package:tempedia/models/location.dart';

class TemtemLocationListPage extends StatefulWidget {
  const TemtemLocationListPage({super.key});

  @override
  State<StatefulWidget> createState() => _TemtemLocationListPageState();
}

class _TemtemLocationListPageState extends State<TemtemLocationListPage> {
  String query = '';
  int pageSize = 20;

  @override
  void initState() {
    super.initState();
  }

  final LoadMoreListViewController _controller = LoadMoreListViewController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Location')),
      body: LoadMoreListView(
        controller: _controller,
        itemBuilder: (item, i) => TemtemLocationListItem(
          data: item,
          index: i,
        ),
        loader: findTemtemLocations,
      ),
    );
  }

  Future<LoadResult?> findTemtemLocations(int page) async {
    try {
      final r = await api.findTemtemLocations(
        query: query,
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
}
