import 'package:flutter/material.dart';

class TemtemTechniquePriorityIcon extends StatelessWidget {
  final int priority;
  final double size;
  const TemtemTechniquePriorityIcon(
      {super.key, required this.priority, this.size = 24});

  static const Map<int, String> priorityAssetMap = {
    0: 'assets/image/Priority_VeryLow.png',
    1: 'assets/image/Priority_Low.png',
    2: 'assets/image/Priority_Normal.png',
    3: 'assets/image/Priority_High.png',
    4: 'assets/image/Priority_VeryHigh.png',
    5: 'assets/image/Priority_Ultra.png',
  };

  @override
  Widget build(BuildContext context) {
    final asset = priorityAssetMap[priority];
    if (asset == null) {
      return Container();
    }
    return Image.asset(
      asset,
      // width: size,
      fit: BoxFit.fitHeight,
      height: size,
    );
  }
}
