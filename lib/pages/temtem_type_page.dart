import 'package:flutter/material.dart';
import 'package:tempedia/components/divider_with_text.dart';
import 'package:tempedia/components/html_view.dart';
import 'package:tempedia/components/temtem/temtem_type_icon.dart';
import 'package:tempedia/models/temtem.dart';

class TemtemTypePage extends StatefulWidget {
  final TemtemType data;
  const TemtemTypePage({super.key, required this.data});

  @override
  State<StatefulWidget> createState() => _TemtemTypePageState();
}

class _TemtemTypePageState extends State<TemtemTypePage> {
  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    return Scaffold(
      appBar: AppBar(title: Text(data.name)),
      body: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        padding: const EdgeInsets.all(10),
        // child: Column(
        children: [
          Row(
            children: [
              TemtemTypeIcon(
                name: data.name,
                size: 96,
                tag: 'temtem-type-list',
              ),
              Hero(
                tag: "temtem-type-name-${data.name}",
                child: Material(
                  color: Colors.transparent,
                  child: FittedBox(
                    child: Text(
                      data.name,
                      style: const TextStyle(fontSize: 46),
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
          const DividerWithText(text: 'Effective against'),
          Row(
            children: data.effectiveAgainst.isNotEmpty
                ? data.effectiveAgainst
                    .map((e) => TemtemTypeIcon(
                          name: e,
                          size: 40,
                        ))
                    .toList()
                : const [Text('None')],
          ),
          const DividerWithText(text: 'Ineffective against'),
          Row(
            children: data.ineffectiveAgainst.isNotEmpty
                ? data.ineffectiveAgainst
                    .map((e) => TemtemTypeIcon(
                          name: e,
                          size: 40,
                        ))
                    .toList()
                : const [Text('None')],
          ),
          const DividerWithText(text: 'Resistant to'),
          Row(
            children: data.resistantTo.isNotEmpty
                ? data.resistantTo
                    .map((e) => TemtemTypeIcon(
                          name: e,
                          size: 40,
                        ))
                    .toList()
                : const [Text('None')],
          ),
          const DividerWithText(text: 'Weak to'),
          Row(
            children: data.weakTo.isNotEmpty
                ? data.weakTo
                    .map((e) => TemtemTypeIcon(
                          name: e,
                          size: 40,
                        ))
                    .toList()
                : const [Text('None')],
          ),
        ],
        // ),
      ),
    );
  }
}
