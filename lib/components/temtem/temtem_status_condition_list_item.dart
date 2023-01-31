import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:tempedia/api/file.dart';
import 'package:tempedia/components/html_view.dart';
import 'package:tempedia/components/text_tag.dart';
import 'package:tempedia/models/condition.dart';
import 'package:tempedia/pages/temtem_status_condition_page.dart';
import 'package:tempedia/utils/transition.dart';

class TemtemStatusConditionListItem extends StatefulWidget {
  final TemtemStatusCondition data;
  const TemtemStatusConditionListItem({super.key, required this.data});

  @override
  State<StatefulWidget> createState() => _TemtemStatusConditionListItemState();
}

class _TemtemStatusConditionListItemState
    extends State<TemtemStatusConditionListItem> {
  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            DefaultMaterialPageRoute(
              builder: (_) => TemtemStatusConditionPage(data: data),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: fileurl(data.icon),
                    width: 25,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 20),
                    child: Text(
                      data.name,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(child: Container()),
                  TextTag(
                    text: data.group,
                    padding: const EdgeInsets.only(
                        left: 4, right: 4, top: 2, bottom: 2),
                  )
                ],
              ),
              HtmlView(
                data: '<i>${data.description}</i>',
                style: {
                  "img": Style(width: 12, height: 12),
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
