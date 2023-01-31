import 'package:flutter/material.dart';
import 'package:tempedia/models/temtem.dart';

class TemtemEvolveMethod extends StatelessWidget {
  final TemtemEvolvesTo method;

  const TemtemEvolveMethod({super.key, required this.method});

  @override
  Widget build(BuildContext context) {
    String text = '';
    if (method.method == 'levelplus') {
      text = '+${method.level} Levels';
      if (method.gender == 'female') {
        text = 'Female $text';
      } else if (method.gender == 'male') {
        text = 'Male $text';
      }
    } else if (method.method == 'tv') {
      text = '${method.tv} TVs';
    } else if (method.method == 'place') {
      text = method.place;
    } else if (method.method == 'trade') {
      text = 'Trade';
    }
    return Container(
      width: 74,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 3, right: 3),
      child: Column(
        children: [
          Image.asset(
            'assets/image/Priority_High.png',
            width: 64,
          ),
          Text(
            text,
            style: const TextStyle(color: Color(0xFF755b75), fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
