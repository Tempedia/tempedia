import 'package:flutter/material.dart';
import 'package:tempedia/components/temtem/temtem_small_list_item_with_traits.dart';
import 'package:tempedia/models/temtem.dart';

class TemtemSmallListWithTraits extends StatefulWidget {
  final List<Temtem> temtems;

  const TemtemSmallListWithTraits({super.key, this.temtems = const []});

  @override
  State<StatefulWidget> createState() => _TemtemSmallListWithTraitsState();
}

class _TemtemSmallListWithTraitsState extends State<TemtemSmallListWithTraits> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.temtems.length,
      itemBuilder: (_, i) => TemtemListItemWithTraits(
        data: widget.temtems[i],
      ),
    );
  }
}
