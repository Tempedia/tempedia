import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tempedia/api/temtem.dart' as api;
import 'package:tempedia/components/loading.dart';
import 'package:tempedia/components/temtem/temtem_general_search_delegate.dart';
import 'package:tempedia/models/temtem.dart';

class TemtemSearchDelegate extends SearchDelegate {
  // final Function(Temtem)? onTap;

  TemtemSearchDelegate();

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
          final data = snapshot.data as List<Temtem>;
          return ListView.builder(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            itemBuilder: (context, index) => TemtemSearchTemtemItem(
              data: data[index],
              onTap: () {
                close(context, data[index]);
              },
            ),
            itemCount: data.length,
          );
        } else {
          return const Loading();
        }
      },
    );
  }

  Future<List<Temtem>> search(String q) async {
    try {
      final r = await api.findTemtems(
        query: q,
        page: 1,
        pageSize: 10,
        withTechnique: true,
      );
      return r.list;
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Network Error",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
    return [];
  }
}

// class _TemtemSearchTemtemItem extends StatelessWidget {
//   final Temtem data;

//   const _TemtemSearchTemtemItem({super.key, required this.data});

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: TemtemIcon(
//         fileid: data.icon,
//         size: 40,
//       ),
//       title: Text(data.name),
//       subtitle: Text('#${data.NO()}'),
//       trailing: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: data.type
//             .map((e) => TemtemTypeIcon(
//                   name: e,
//                   size: 22,
//                 ))
//             .toList(),
//       ),
//       onTap: () {
//         Navigator.push(
//           context,
//           DefaultMaterialPageRoute(
//             builder: (context) => TemtemPage(data: data),
//           ),
//         );
//       },
//     );
//   }
// }
