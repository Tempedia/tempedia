import 'package:flutter/material.dart';

class GenderRatioBar extends StatelessWidget {
  final double height;
  final int male;
  final int female;
  const GenderRatioBar(
      {super.key, this.height = 24, required this.male, required this.female});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        border: Border.all(
          color: Colors.grey.shade400,
        ),
      ),
      child: Stack(
        children: [
          Row(
            children: <Widget>[
              Expanded(
                flex: male,
                child: Container(
                  color: const Color(0xffbbdefb),
                ),
              ),
              Expanded(
                flex: female,
                child: Container(
                  color: const Color(0xfff8bbd0),
                ),
              ),
            ],
          ),
          Center(
            child: Text(
              (male > 0 || female > 0)
                  ? '$male% Male, $female% Female'
                  : 'No Gender',
              style: const TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
