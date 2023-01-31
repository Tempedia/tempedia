import 'package:flutter/material.dart';
import 'package:tempedia/components/admob/admob_banner.dart';
import 'package:tempedia/components/divider_with_text.dart';
import 'package:tempedia/components/gallery_image_list.dart';
import 'package:tempedia/components/temtem/temtem_subspecies.dart';
import 'package:tempedia/models/temtem.dart';

class TemtemPageGalleryFragment extends StatefulWidget {
  final List<GalleryImage> gallery;
  final List<GalleryImage> renders;
  final List<TemtemSubspecie> subspecies;

  const TemtemPageGalleryFragment({
    super.key,
    required this.gallery,
    required this.renders,
    required this.subspecies,
  });

  @override
  State<StatefulWidget> createState() => _TemtemPageGalleryFragmentState();
}

class _TemtemPageGalleryFragmentState extends State<TemtemPageGalleryFragment>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const AdMobBanner(),
            widget.subspecies.isNotEmpty
                ? const DividerWithText(text: 'Subspecies')
                : Container(),
            widget.subspecies.isNotEmpty
                ? TemtemSubspecies(subspecies: widget.subspecies)
                : Container(),
            const DividerWithText(text: 'Gallery'),
            GalleryImageList(images: widget.gallery),
            const DividerWithText(text: 'Renders'),
            GalleryImageList(images: widget.renders),
          ],
        ),
      ),
    );
  }
}
