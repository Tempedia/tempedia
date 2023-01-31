import 'package:flutter/material.dart';
import 'package:tempedia/api/file.dart';
import 'package:tempedia/components/gallery_image_item.dart';
import 'package:tempedia/components/image_viewer.dart';
import 'package:tempedia/components/text_tag.dart';
import 'package:tempedia/models/location.dart';
import 'package:tempedia/models/temtem.dart';
import 'package:tempedia/pages/temtem_location_page.dart';
import 'package:tempedia/utils/transition.dart';

class TemtemLocationListItem extends StatefulWidget {
  final int index;
  final TemtemLocation data;
  const TemtemLocationListItem({super.key, required this.data, this.index = 0});
  @override
  State<StatefulWidget> createState() => _TemtemLocationListItemState();
}

class _TemtemLocationListItemState extends State<TemtemLocationListItem> {
  tagName() {
    return 'location-list-${widget.index}';
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRouteWithFadeTransition(
              builder: (_) => TemtemLocationPage(
                data: data,
                tag: tagName(),
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ImageViewer(
                fileid: data.image,
                width: 120,
                height: 60,
                tag: tagName(),
                openable: false,
              ),
              Container(
                margin: const EdgeInsets.only(left: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: tagName(),
                      child: Material(
                        color: Colors.transparent,
                        child: FittedBox(
                          child: Text(
                            data.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: TextTag(
                        text: data.island,
                        padding: const EdgeInsets.only(
                          left: 4,
                          right: 4,
                          top: 1,
                          bottom: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
