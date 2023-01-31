import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:tempedia/api/file.dart';
import 'package:tempedia/models/temtem.dart';
import 'package:tempedia/pages/gallery_image_viewer_page.dart';
import 'package:tempedia/utils/transition.dart';

class TemtemIconClipPathClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    // polygon(51% 5%,88% 28%,89% 73%,50% 92%,14% 72%,12% 29%);
    final width = size.width;
    final height = size.height;
    path.moveTo(width * 0.51, height * 0.05);
    path.lineTo(width * 0.88, height * 0.28);
    path.lineTo(width * 0.89, height * 0.73);
    path.lineTo(width * 0.5, height * 0.92);
    path.lineTo(width * 0.14, height * 0.72);
    path.lineTo(width * 0.12, height * 0.29);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class TemtemIcon extends StatefulWidget {
  final String fileid;
  final double size;
  final String? tag;
  final bool tappable;

  const TemtemIcon({
    super.key,
    required this.fileid,
    this.size = 100,
    this.tag,
    this.tappable = false,
  });

  @override
  State<StatefulWidget> createState() => _TemtemIconState();
}

class _TemtemIconState extends State<TemtemIcon> {
  @override
  Widget build(BuildContext context) {
    if (widget.tag == null) {
      return rawBuild(context);
    }
    return Hero(
      tag: '${widget.tag} - ${widget.fileid}',
      child: Material(
        color: Colors.transparent,
        child: rawBuild(context),
      ),
    );
  }

  Widget rawBuild(BuildContext context) {
    return GestureDetector(
      onTap: widget.tappable ? onTap : null,
      child: Container(
        alignment: Alignment.center,
        width: widget.size,
        height: widget.size,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/image/Temtem_portrait_background.png"),
          ),
        ),
        child: Stack(
          children: [
            ClipPath(
              clipper: TemtemIconClipPathClass(),
              child: CachedNetworkImage(
                imageUrl: fileurl(widget.fileid),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fadeInDuration: const Duration(milliseconds: 100),
              ),
            ),
            Image.asset(
              'assets/image/Temtem_portrait_border.png',
            ),
          ],
        ),
      ),
    );
  }

  onTap() {
    Navigator.push(
      context,
      MaterialPageRouteWithFadeTransition(
        builder: (_) => GalleryImageViewerPage(
          image: GalleryImage(text: '', fileid: widget.fileid, group: ''),
          heroTag: '${widget.tag} - ${widget.fileid}',
        ),
      ),
    );
  }
}
