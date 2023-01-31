import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

ImageRender cachedNetworkImageRender() => (context, attributes, element) {
      double? width, height;
      if (attributes['width'] != null) {
        width = double.parse(attributes['width'] ?? '0');
      }
      if (attributes['height'] != null) {
        height = double.parse(attributes['height'] ?? '0');
      }
      return CachedNetworkImage(
          imageUrl: attributes["src"] ?? "about:blank",
          width: width,
          height: height);
    };

class HtmlView extends StatelessWidget {
  final String data;
  final Map<String, Style> style;

  const HtmlView({super.key, required this.data, this.style = const {}});

  @override
  Widget build(BuildContext context) {
    return Html(
      data: data,
      style: style,
      customImageRenders: {
        networkSourceMatcher(): cachedNetworkImageRender(),
      },
    );
  }
}
