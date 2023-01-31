import 'package:flutter/material.dart';
import 'package:tempedia/api/temtem.dart' as api;
import 'package:tempedia/components/temtem/temtem_icon.dart';
import 'package:tempedia/models/temtem.dart';

class TemtemIconFromName extends StatefulWidget {
  final String name;
  final double size;
  final String? tag;
  const TemtemIconFromName(
      {super.key, required this.name, this.size = 40, this.tag});

  @override
  State<StatefulWidget> createState() => _TemtemIconFromNameState();
}

class _TemtemIconFromNameState extends State<TemtemIconFromName> {
  @override
  void initState() {
    super.initState();
    getTemtem();
  }

  Temtem? data;

  @override
  Widget build(BuildContext context) {
    return data != null
        ? TemtemIcon(
            fileid: data!.icon,
            size: widget.size,
            tag: widget.tag,
          )
        : Container();
  }

  getTemtem() async {
    try {
      data = await api.getTemtem(widget.name);
      setState(() {});
    } finally {}
  }
}
