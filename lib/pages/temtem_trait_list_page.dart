import 'package:flutter/material.dart';
import 'package:tempedia/api/api.dart';
import 'package:tempedia/api/trait.dart';
import 'package:tempedia/components/loadmore_list_view.dart';
import 'package:tempedia/components/temtem/temtem_trait_card.dart';
import 'package:tempedia/models/trait.dart';

class TemtemTraitListPage extends StatefulWidget {
  const TemtemTraitListPage({super.key});

  @override
  State<StatefulWidget> createState() => _TemtemTraitListPageState();
}

class _TemtemTraitListPageState extends State<TemtemTraitListPage> {
  final LoadMoreListViewController _controller = LoadMoreListViewController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trait')),
      body: LoadMoreListView(
        controller: _controller,
        loader: load,
        itemBuilder: (item, _) => TemtemTraitCard(
          name: (item as TemtemTrait).name,
          data: item,
        ),
      ),
    );
  }

  String query = '';
  int pageSize = 20;
  Future<LoadResult?> load(int page) async {
    try {
      final r =
          await findTemtemTraits(query: query, page: page, pageSize: pageSize);
      return LoadResult(list: r.list, hasMore: r.list.length >= pageSize);
    } on ApiException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unknown Error'),
        ),
      );
    }
    return null;
  }
}
