import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tempedia/components/team/team_temtem_technique_item.dart';
import 'package:tempedia/models/team.dart';
import 'package:tempedia/models/technique.dart';

class TeamTemtemTechniqueEditing extends StatefulWidget {
  final List<TeamTemtemTechnique> selected;
  final List<TemtemLevelingUpTechnique> levelingUpTechniques;
  final List<TemtemCourseTechnique> courseTechniques;
  final List<TemtemBreedingTechnique> breedingTechniques;
  const TeamTemtemTechniqueEditing({
    super.key,
    required this.selected,
    required this.levelingUpTechniques,
    required this.courseTechniques,
    required this.breedingTechniques,
  });

  @override
  State<StatefulWidget> createState() => _TeamTemtemTechniqueEditingState();
}

class _TeamTemtemTechniqueEditingState
    extends State<TeamTemtemTechniqueEditing> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    List<String> allTechniqueNames = [];
    List<String> selectedNames = [];
    for (var t in widget.levelingUpTechniques) {
      children.add(
        LayoutId(
          id: t.technique.name,
          child: _createTechniqueItem(t.technique, false, false),
        ),
      );
      allTechniqueNames.add(t.technique.name);
    }
    for (var t in widget.courseTechniques) {
      children.add(
        LayoutId(
          id: t.technique.name,
          child: _createTechniqueItem(t.technique, false, true),
        ),
      );
      allTechniqueNames.add(t.technique.name);
    }
    for (var t in widget.breedingTechniques) {
      children.add(
        LayoutId(
          id: t.technique.name,
          child: _createTechniqueItem(t.technique, true, false),
        ),
      );
      allTechniqueNames.add(t.technique.name);
    }

    for (var s in widget.selected) {
      selectedNames.add(s.technique.name);
    }

    return SizedBox(
      height: (allTechniqueNames.length - selectedNames.length) * 42,
      child: CustomMultiChildLayout(
        delegate: _TechniqueLayoutDelegate(
          names: allTechniqueNames,
          selected: selectedNames,
          active: active,
          activeOffset: activeOffset,
        ),
        children: children,
      ),
    );
  }

  _createTechniqueItem(TemtemTechnique technique, bool egg, bool course) {
    return GestureDetector(
      onPanStart: (d) {
        onPanStart(d, technique.name);
        setState(() {});
      },
      onPanUpdate: (d) {
        onPanUpdate(d, technique.name);
        setState(() {});
      },
      onPanEnd: (d) {
        onPanEnd(d);
        setState(() {});
      },
      child: SizedBox(
        height: 42,
        child: TeamTemtemTechniqueItem(
          data: technique,
          egg: egg,
          course: course,
        ),
      ),
    );
  }
}

String active = '';
Offset? activeOffset;
onPanStart(DragStartDetails details, String name) {
  active = name;
  activeOffset = details.localPosition;
}

onPanUpdate(DragUpdateDetails details, String name) {
  print(details);
  active = name;
  activeOffset = details.localPosition;
}

onPanEnd(DragEndDetails details) {
  active = '';
  activeOffset = null;
}

class _TechniqueLayoutDelegate extends MultiChildLayoutDelegate {
  List<String> names = [];
  List<String> selected = [];
  String active = '';
  Offset? activeOffset;
  _TechniqueLayoutDelegate({
    required this.names,
    required this.selected,
    required this.active,
    required this.activeOffset,
  });

  @override
  void performLayout(Size size) {
    final double columnWidth = size.width / 2;
    Offset childPosition = Offset.zero;

    for (var n in selected) {
      final Size currentSize = layoutChild(
        n,
        BoxConstraints(
          minHeight: 42,
          maxHeight: 42,
          maxWidth: columnWidth,
          minWidth: columnWidth,
        ),
      );
      if (active == n && activeOffset != null) {
        // final pos = activeOffset! - Offset(size.width / 2, size.height / 2);
        positionChild(n, activeOffset!);
      } else {
        positionChild(n, childPosition);
      }
      childPosition += Offset(0, currentSize.height);
    }

    childPosition = Offset(columnWidth, 0);
    for (var n in names) {
      if (selected.contains(n)) {
        continue;
      }
      final Size currentSize = layoutChild(
        n,
        BoxConstraints(
          minHeight: 42,
          maxHeight: 42,
          maxWidth: columnWidth,
          minWidth: columnWidth,
        ),
      );
      if (active == n && activeOffset != null) {
        // final pos = activeOffset! - Offset(size.width / 2, size.height / 2);
        positionChild(n, activeOffset!);
      } else {
        positionChild(n, childPosition);
      }
      childPosition += Offset(0, currentSize.height);
    }
  }

  @override
  bool shouldRelayout(covariant _TechniqueLayoutDelegate oldDelegate) {
    // return !(listEquals(oldDelegate.selected, selected) &&
    //     listEquals(oldDelegate.names, names));
    return true;
  }
}
