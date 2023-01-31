import 'package:flutter/material.dart';
import 'package:tempedia/components/expandable_tabview.dart';
import 'package:tempedia/components/gallery_image_item.dart';
import 'package:tempedia/models/temtem.dart';

class GalleryImageList extends StatelessWidget {
  final List<GalleryImage> images;
  const GalleryImageList({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    final List<String> groups = [];
    for (var img in images) {
      if (img.group.isNotEmpty && !groups.contains(img.group)) {
        groups.add(img.group);
      }
    }
    if (groups.isEmpty) {
      return buildList(images);
    }

    final List<List<GalleryImage>> groupImages = List.generate(
      groups.length,
      (_) => <GalleryImage>[],
    );
    for (var i = 0; i < groups.length; i++) {
      for (var t in images) {
        if (t.group == groups[i]) {
          groupImages[i].add(t);
        }
      }
    }

    return ExpandableTabView(
        tabs: groups,
        children: groupImages
            .map(
              (e) => buildList(e),
            )
            .toList());
  }

  Widget buildList(List<GalleryImage> list) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      primary: false,
      children: list
          .map(
            (e) => GalleryImageItem(
              image: e,
            ),
          )
          .toList(),
    );
  }
}
