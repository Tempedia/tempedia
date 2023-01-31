import 'package:flutter/material.dart';
import 'package:tempedia/components/temtem/temtem_small_item.dart';
import 'package:tempedia/models/technique.dart';

class TemtemTechniqueCourseTemtemItem extends StatefulWidget {
  final TemtemCourseTechnique technique;
  TemtemTechniqueCourseTemtemItem({super.key, required this.technique})
      : assert(technique.temtem != null);

  @override
  State<StatefulWidget> createState() =>
      _TemtemTechniqueCourseTemtemItemState();
}

class _TemtemTechniqueCourseTemtemItemState
    extends State<TemtemTechniqueCourseTemtemItem> {
  @override
  Widget build(BuildContext context) {
    final data = widget.technique.temtem!;
    return TemtemSmallItem(
      data: data,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('#'),
          Text(
            widget.technique.course,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}

class TemtemTechniqueCourseTemtemList extends StatelessWidget {
  final List<TemtemCourseTechnique> temtems;

  const TemtemTechniqueCourseTemtemList({super.key, required this.temtems});

  @override
  Widget build(BuildContext context) {
    if (temtems.isEmpty) {
      return Container(
        alignment: Alignment.center,
        height: 60,
        child: const Text(
          'No Temtem',
          style: TextStyle(fontSize: 12),
        ),
      );
    }
    return Column(
      children: temtems
          .map((e) => TemtemTechniqueCourseTemtemItem(
                technique: e,
              ))
          .toList(),
    );
  }
}
