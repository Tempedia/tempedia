import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tempedia/api/file.dart';
import 'package:tempedia/models/temtem.dart';
import 'package:tempedia/pages/gallery_image_viewer_page.dart';
import 'package:tempedia/utils/transition.dart';

class ImageViewer extends StatefulWidget {
  final String fileid;
  final String? tag;
  final double? width;
  final double? height;
  final bool openable;
  const ImageViewer({
    super.key,
    required this.fileid,
    this.tag,
    this.width,
    this.height,
    this.openable = true,
  });

  @override
  State<StatefulWidget> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.openable ? onTap : null,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(4),
          width: widget.width,
          height: widget.height,
          child: widget.tag != null
              ? Hero(
                  tag: heroTag(),
                  child: CachedNetworkImage(
                    imageUrl: fileurl(widget.fileid),
                    fit: BoxFit.contain,
                  ),
                )
              : CachedNetworkImage(
                  imageUrl: fileurl(widget.fileid),
                  fit: BoxFit.contain,
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
          image: GalleryImage(fileid: widget.fileid, text: '', group: ''),
          heroTag: heroTag(),
        ),
      ),
    );
  }

  String heroTag() {
    return '${widget.tag}-${widget.fileid}';
  }
}
