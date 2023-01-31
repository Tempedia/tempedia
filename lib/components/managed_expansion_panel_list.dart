import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class ManagedExpansionPanelData {
  final String title;
  final String? subtitle;

  final Widget body;

  ManagedExpansionPanelData({
    required this.title,
    this.subtitle,
    required this.body,
  });
}

class ManagedExpansionPanelList extends StatefulWidget {
  final List<ManagedExpansionPanelData> panels;

  const ManagedExpansionPanelList({super.key, required this.panels});

  @override
  State<StatefulWidget> createState() => _ManagedExpansionPanelListState();
}

class _ManagedExpansionPanelListState extends State<ManagedExpansionPanelList> {
  late List<bool> expanded;

  @override
  void initState() {
    super.initState();

    expanded = List.filled(widget.panels.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (panelIndex, isExpanded) {
        expanded[panelIndex] = !isExpanded;
        setState(() {});
      },
      children: widget.panels
          .mapIndexed(
            (i, e) => ExpansionPanel(
              canTapOnHeader: true,
              isExpanded: expanded[i],
              headerBuilder: (context, isExpanded) => ListTile(
                title: Text(e.title),
                subtitle: e.subtitle != null ? Text(e.subtitle!) : null,
              ),
              body: e.body,
            ),
          )
          .toList(),
    );
  }
}
