import 'package:flutter/material.dart';
import 'package:tempedia/api/api.dart';
import 'package:tempedia/api/technique.dart';
import 'package:tempedia/components/html_view.dart';
import 'package:tempedia/components/loadmore_list_view.dart';
import 'package:tempedia/components/temtem/temtem_base_technique_item.dart';
import 'package:tempedia/models/technique.dart';

class TemtemTechniqueCourseListPage extends StatefulWidget {
  const TemtemTechniqueCourseListPage({super.key});

  @override
  State<StatefulWidget> createState() => _TemtemTechniqueCourseListPageState();
}

class _TemtemTechniqueCourseListPageState
    extends State<TemtemTechniqueCourseListPage> {
  final LoadMoreListViewController controller = LoadMoreListViewController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Technique Course'),
      ),
      body: LoadMoreListView(
        controller: controller,
        loader: load,
        itemBuilder: (item, i) => TemtemBaseTechniqueItem(
          data: TemtemTechqniueBase(
            stab: false,
            technique: (item as TemtemCourseItem).technique,
          ),
          childPosition: TemtemBaseTechniqueItemChildPosition.top,
          child: Container(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row(
                //   children: [
                //     Image.asset(
                //       'assets/image/TechniqueCourse.png',
                //       width: 40,
                //       // height: 40,
                //     ),
                //     Text(
                //       '#${item.no}',
                //       style: const TextStyle(
                //         fontSize: 24,
                //         fontWeight: FontWeight.w600,
                //       ),
                //     ),
                //   ],
                // ),
                Text(
                  '#${item.no}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                HtmlView(data: 'Source: ${item.source}'),
                const Divider(
                  thickness: 1,
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String query = '';
  int pageSize = 30;
  Future<LoadResult?> load(int page) async {
    try {
      final r = await findTemtemTechniqueCourses(
        query: query,
        page: page,
        pageSize: pageSize,
      );
      return LoadResult(
        list: r.list,
        hasMore: r.list.length >= pageSize,
      );
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
