import 'package:flutter/material.dart';
import 'package:tempedia/components/loading.dart';

class LoadResult {
  final List<dynamic> list;
  final bool hasMore;

  const LoadResult({required this.list, required this.hasMore});
}

class LoadMoreListViewController extends ChangeNotifier {
  void reset() {
    notifyListeners();
  }
}

class LoadMoreListView extends StatefulWidget {
  final Widget Function(dynamic, int) itemBuilder;
  final Future<LoadResult?> Function(int) loader;
  final LoadMoreListViewController controller;
  const LoadMoreListView({
    super.key,
    required this.itemBuilder,
    required this.loader,
    required this.controller,
  });

  @override
  State<StatefulWidget> createState() => _LoadMoreListViewState();
}

class _LoadMoreListViewState extends State<LoadMoreListView> {
  List<dynamic> items = [];

  int page = 1;
  bool loading = false;
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    load();

    widget.controller.addListener(() {
      page = 1;
      items = [];
      load();
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollEndNotification>(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        padding: const EdgeInsets.only(bottom: 20, top: 5),
        itemCount: items.length + 1,
        itemBuilder: (_, i) {
          if (i < items.length) {
            return widget.itemBuilder(items[i], i);
          }
          return Loading(
            loading: loading,
          );
        },
      ),
      onNotification: (notification) {
        if (notification.metrics.pixels >=
                notification.metrics.maxScrollExtent - 500 &&
            hasMore) {
          load();
        }
        return false;
      },
    );
  }

  int seq = 0;
  load() async {
    if (loading) {
      return;
    }
    try {
      setState(() {
        loading = true;
      });
      final r = await widget.loader(page);
      if (r != null) {
        if (page == 1) {
          items = r.list;
        } else {
          items.addAll(r.list);
        }
        hasMore = r.hasMore;
        page += 1;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Network Error'),
        ),
      );
      print(e);
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }
}
