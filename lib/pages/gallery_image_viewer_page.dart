import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:tempedia/api/file.dart';
import 'package:tempedia/components/html_view.dart';
import 'package:tempedia/models/temtem.dart';

class GalleryImageViewerPage extends StatelessWidget {
  final GalleryImage image;
  final String? heroTag;

  const GalleryImageViewerPage({super.key, required this.image, this.heroTag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PhotoView(
            imageProvider: CachedNetworkImageProvider(fileurl(image.fileid)),
            backgroundDecoration: const BoxDecoration(color: Colors.white),
            heroAttributes:
                heroTag != null ? PhotoViewHeroAttributes(tag: heroTag!) : null,
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: image.text.isNotEmpty ? HtmlView(data: image.text) : null,
          ),
        ],
      ),
    );
  }
}
