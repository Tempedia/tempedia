import 'package:flutter/material.dart';
import 'package:tempedia/components/temtem/temtem_technique_class_icon.dart';

class _TemtemTechniqueClassToggleItem extends StatelessWidget {
  final String cls;
  final bool selected;

  const _TemtemTechniqueClassToggleItem({
    required this.cls,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      margin: const EdgeInsets.only(top: 2, bottom: 2),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        color:
            selected ? Theme.of(context).backgroundColor : Colors.transparent,
      ),
      child: Row(
        children: [
          TemtemTechniqueClassIcon(cls: cls),
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.only(left: 20),
              child: Text(
                cls,
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ),
          selected
              ? Icon(
                  Icons.check_circle_outline,
                  color: Theme.of(context).primaryColor,
                )
              : Container(),
        ],
      ),
    );
  }
}

class TemtemTechniqueClassToggleButtons extends StatefulWidget {
  final List<String> selected;
  final Function(List<String>)? onSelected;
  final int num;

  const TemtemTechniqueClassToggleButtons(
      {super.key, required this.selected, this.onSelected, this.num = 1});

  @override
  State<StatefulWidget> createState() =>
      _TemtemTechniqueClassToggleButtonsState();
}

class _TemtemTechniqueClassToggleButtonsState
    extends State<TemtemTechniqueClassToggleButtons> {
  static const List<String> classes = ['Physical', 'Special', 'Status'];
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 600,
      width: 400,
      child: Column(
          children: classes
              .map(
                (e) => InkWell(
                  onTap: () => onTypeSelected(e),
                  child: Material(
                    color: Colors.transparent,
                    child: _TemtemTechniqueClassToggleItem(
                      cls: e,
                      selected: widget.selected.contains(e),
                    ),
                  ),
                ),
              )
              .toList()),
      // child: ListView.builder(
      //   itemCount: types.length,
      //   itemBuilder: (_, index) => InkWell(
      //     onTap: () => onTypeSelected(types[index]),
      //     child: Material(
      //       color: Colors.transparent,
      //       child: _TemtemTypeToggleItem(
      //         size: widget.size,
      //         type: types[index],
      //         selected: widget.selected.contains(types[index].name),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  onTypeSelected(String cls) {
    final t = List<String>.from(widget.selected);
    if (t.contains(cls)) {
      t.remove(cls);
      widget.onSelected!(t);
    } else {
      if (t.length >= widget.num) {
        return;
      } else {
        t.add(cls);
        widget.onSelected!(t);
      }
    }
  }
}
