import 'package:flutter/material.dart';
import 'package:tempedia/components/html_view.dart';
import 'package:tempedia/components/temtem/temtem_type_icon.dart';
import 'package:tempedia/models/temtem.dart';
import 'package:tempedia/pages/temtem_type_page.dart';
import 'package:tempedia/utils/transition.dart';

class TemtemTypeListItem extends StatefulWidget {
  final TemtemType data;
  const TemtemTypeListItem({super.key, required this.data});

  @override
  State<StatefulWidget> createState() => _TemtemTypeListItemState();
}

class _TemtemTypeListItemState extends State<TemtemTypeListItem> {
  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRouteWithFadeTransition(
              builder: (_) => TemtemTypePage(
                data: data,
              ),
            ),
          );
        },
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(children: [
              Row(
                children: [
                  TemtemTypeIcon(
                    name: data.name,
                    size: 64,
                    tag: 'temtem-type-list',
                  ),
                  Hero(
                    tag: "temtem-type-name-${data.name}",
                    child: Material(
                      color: Colors.transparent,
                      child: FittedBox(
                        child: Text(
                          data.name,
                          style: const TextStyle(fontSize: 40),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Hero(
                tag: "temtem-type-${data.name}-comment",
                child: Material(
                  color: Colors.transparent,
                  child: HtmlView(data: '<i>${data.comment}</i>'),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
