import 'package:flutter/material.dart';
import 'package:tempedia/components/text_tag.dart';
import 'package:tempedia/models/temtem.dart';

class TVYieldTags extends StatelessWidget {
  final TemtemTVYield tvYield;

  const TVYieldTags({super.key, required this.tvYield});

  @override
  Widget build(BuildContext context) {
    List<Widget> tvYields = [
      const Text('TV Yield: '),
    ];
    const tvPadding = EdgeInsets.only(left: 4, right: 4, top: 2, bottom: 2);
    if (tvYield.hp > 0) {
      tvYields.add(
        Container(
          margin: const EdgeInsets.only(left: 4, right: 4),
          child: TextTag(
            text: 'HP+${tvYield.hp}',
            textSize: 10,
            padding: tvPadding,
          ),
        ),
      );
    }
    if (tvYield.sta > 0) {
      tvYields.add(
        Container(
          margin: const EdgeInsets.only(left: 4, right: 4),
          child: TextTag(
            text: 'STA+${tvYield.sta}',
            textSize: 10,
            padding: tvPadding,
          ),
        ),
      );
    }
    if (tvYield.spd > 0) {
      tvYields.add(
        Container(
          margin: const EdgeInsets.only(left: 4, right: 4),
          child: TextTag(
            text: 'SPD+${tvYield.spd}',
            textSize: 10,
            padding: tvPadding,
          ),
        ),
      );
    }
    if (tvYield.atk > 0) {
      tvYields.add(
        Container(
          margin: const EdgeInsets.only(left: 4, right: 4),
          child: TextTag(
            text: 'ATK+${tvYield.atk}',
            textSize: 10,
            padding: tvPadding,
          ),
        ),
      );
    }
    if (tvYield.def > 0) {
      tvYields.add(
        Container(
          margin: const EdgeInsets.only(left: 4, right: 4),
          child: TextTag(
            text: 'DEF+${tvYield.def}',
            textSize: 10,
            padding: tvPadding,
          ),
        ),
      );
    }
    if (tvYield.spatk > 0) {
      tvYields.add(
        Container(
          margin: const EdgeInsets.only(left: 4, right: 4),
          child: TextTag(
            text: 'SPATK+${tvYield.spatk}',
            textSize: 10,
            padding: tvPadding,
          ),
        ),
      );
    }
    if (tvYield.spdef > 0) {
      tvYields.add(
        Container(
          margin: const EdgeInsets.only(left: 4, right: 4),
          child: TextTag(
            text: 'SPDEF+${tvYield.spdef}',
            textSize: 10,
            padding: tvPadding,
          ),
        ),
      );
    }
    return Row(
      children: tvYields,
    );
  }
}
