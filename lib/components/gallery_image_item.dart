import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tempedia/api/file.dart';
import 'package:tempedia/components/html_view.dart';
import 'package:tempedia/models/temtem.dart';
import 'package:tempedia/pages/gallery_image_viewer_page.dart';
import 'package:tempedia/utils/transition.dart';

class GalleryImageItem extends StatefulWidget {
  final GalleryImage image;
  const GalleryImageItem({super.key, required this.image});

  @override
  State<StatefulWidget> createState() => _GalleryImageItemState();
}

class _GalleryImageItemState extends State<GalleryImageItem> {
  @override
  Widget build(BuildContext context) {
    final image = widget.image;
    return InkWell(
      onTap: onTap,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: AspectRatio(
            aspectRatio: 1,
            child: Column(children: [
              Flexible(
                child: Hero(
                  tag: heroTag(),
                  child: CachedNetworkImage(
                    imageUrl: fileurl(image.fileid),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              HtmlView(data: image.text),
            ]),
          ),
        ),
      ),
    );
  }

  onTap() {
    Navigator.push(
      context,
      MaterialPageRouteWithFadeTransition(
        builder: (context) => GalleryImageViewerPage(
          image: widget.image,
          heroTag: heroTag(),
        ),
      ),
    );
  }

  String heroTag() {
    return 'gallery_image_item-${widget.image.fileid}';
  }
}
