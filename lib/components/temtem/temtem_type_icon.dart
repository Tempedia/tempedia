import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tempedia/api/api.dart';

class TemtemTypeIcon extends StatelessWidget {
  final String name;
  final double size;
  final String? tag;

  const TemtemTypeIcon(
      {super.key, required this.name, this.tag, this.size = 32});

  @override
  Widget build(BuildContext context) {
    if (tag == null) {
      return rawBuild(context);
    }
    return Hero(
      tag: '$tag - $name',
      child: Material(
        color: Colors.transparent,
        child: rawBuild(context),
      ),
    );
  }

  Widget rawBuild(BuildContext context) {
    final uri = apiuri('/temtem/type/$name/icon').toString();
    return SizedBox(
      width: size,
      height: size,
      child: CachedNetworkImage(
        imageUrl: uri,
        errorWidget: (context, url, error) => const Icon(Icons.error),
        fadeInDuration: const Duration(milliseconds: 100),
      ),
    );
  }
}
