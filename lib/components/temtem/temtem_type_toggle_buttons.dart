import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tempedia/api/db.dart';
import 'package:tempedia/api/file.dart';
import 'package:tempedia/models/temtem.dart';

class TemtemTypeToggleButtons extends StatefulWidget {
  final Function(List<String>)? onSelected;
  final List<String> selected;
  final int num;
  final TemtemTypeToggleItemSize size;

  const TemtemTypeToggleButtons({
    super.key,
    this.onSelected,
    this.selected = const [],
    this.num = 2,
    this.size = TemtemTypeToggleItemSize.large,
  });

  @override
  State<StatefulWidget> createState() => _TemtemTypeToggleButtonsState();
}

enum TemtemTypeToggleItemSize {
  small,
  large,
}

class _TemtemTypeToggleItem extends StatelessWidget {
  final TemtemType type;
  final bool selected;
  final TemtemTypeToggleItemSize size;

  const _TemtemTypeToggleItem({
    required this.type,
    this.selected = false,
    this.size = TemtemTypeToggleItemSize.large,
  });

  @override
  Widget build(BuildContext context) {
    double imgSize = 36;
    double fontSize = 16;
    double padding = 6;
    double margin = 2;
    if (size == TemtemTypeToggleItemSize.small) {
      imgSize = 25;
      fontSize = 14;
      padding = 4;
      margin = 1;
    }
    return Container(
      padding: EdgeInsets.all(padding),
      margin: EdgeInsets.only(top: margin, bottom: margin),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        color:
            selected ? Theme.of(context).backgroundColor : Colors.transparent,
      ),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: fileurl(type.icon),
            width: imgSize,
            height: imgSize,
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.only(left: 20),
              child: Text(
                type.name,
                style: TextStyle(fontSize: fontSize),
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

class _TemtemTypeToggleButtonsState extends State<TemtemTypeToggleButtons>
    with AutomaticKeepAliveClientMixin {
  List<TemtemType> types = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    findTemtemTypes();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      // height: 600,
      width: 400,
      child: Column(
          children: types
              .map(
                (e) => InkWell(
                  onTap: () => onTypeSelected(e),
                  child: Material(
                    color: Colors.transparent,
                    child: _TemtemTypeToggleItem(
                      size: widget.size,
                      type: e,
                      selected: widget.selected.contains(e.name),
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

  onTypeSelected(TemtemType type) {
    final t = List<String>.from(widget.selected);
    if (t.contains(type.name)) {
      t.remove(type.name);
      widget.onSelected!(t);
    } else {
      if (t.length >= widget.num) {
        return;
      } else {
        t.add(type.name);
        widget.onSelected!(t);
      }
    }
  }

  findTemtemTypes() async {
    try {
      types = await findTemtemTypesWithDB();
    } finally {
      setState(() {});
    }
  }
}
