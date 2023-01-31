import 'package:flutter/material.dart';

class TemtemTechniqueClassIcon extends StatelessWidget {
  final String cls;
  final double size;
  const TemtemTechniqueClassIcon(
      {super.key, required this.cls, this.size = 24});

  static const Map<String, String> clsAssetMap = {
    'Physical': 'assets/image/Physical.png',
    'Special': 'assets/image/Special.png',
    'Status': 'assets/image/Status.png',
  };

  @override
  Widget build(BuildContext context) {
    final asset = clsAssetMap[cls];
    if (asset == null) {
      return Container();
    }
    return Image.asset(
      asset,
      fit: BoxFit.fitHeight,
      height: size,
    );
  }
}
