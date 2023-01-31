import 'package:flutter/material.dart';
import 'package:tempedia/components/temtem/temtem_icon.dart';
import 'package:tempedia/components/temtem/temtem_type_icon.dart';
import 'package:tempedia/models/temtem.dart';
import 'package:tempedia/pages/temtem_page.dart';
import 'package:tempedia/utils/transition.dart';

class TemtemSmallItem extends StatefulWidget {
  final Temtem data;
  final Widget child;
  const TemtemSmallItem({super.key, required this.data, required this.child});

  @override
  State<StatefulWidget> createState() => _TemtemSmallItemState();
}

class _TemtemSmallItemState extends State<TemtemSmallItem> {
  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              DefaultMaterialPageRoute(
                builder: (context) => TemtemPage(data: data),
              ));
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TemtemIcon(
                fileid: data.icon,
                size: 48,
              ),
              Container(
                margin: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '#${data.NO()}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Text(
                      data.name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: data.type
                          .map((e) => TemtemTypeIcon(
                                name: e,
                                size: 16,
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
              widget.child
            ],
          ),
        ),
      ),
    );
  }
}
