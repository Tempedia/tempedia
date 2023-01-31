import 'package:flutter/material.dart';
import 'package:tempedia/api/temtem.dart' as api;
import 'package:tempedia/components/temtem/temtem_icon.dart';
import 'package:tempedia/components/temtem/temtem_type_icon.dart';
import 'package:tempedia/models/location.dart';
import 'package:tempedia/models/temtem.dart';
import 'package:tempedia/pages/temtem_page.dart';
import 'package:tempedia/utils/transition.dart';

class TemtemLocationAreaTemtemItem extends StatefulWidget {
  final TemtemLocationAreaTemtem data;
  const TemtemLocationAreaTemtemItem({super.key, required this.data});

  @override
  State<StatefulWidget> createState() => _TemtemLocationAreaTemtemItemState();
}

class _TemtemLocationAreaTemtemItemState
    extends State<TemtemLocationAreaTemtemItem> {
  Temtem? temtem;
  @override
  void initState() {
    super.initState();
    getTemtem();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    if (temtem == null) {
      return Container();
    }

    final List<Widget> odds = [];
    for (var o in data.odds) {
      odds.add(
        o.desc.isNotEmpty
            ? Tooltip(
                message: o.desc,
                child: Container(
                  margin: const EdgeInsets.only(left: 3, right: 3),
                  child: Text(
                    o.odds,
                    style:
                        const TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
              )
            : Text(o.odds),
      );
    }
    String level = '${data.level.from} - ${data.level.to}';
    if (data.level.egg) {
      level = 'Egg';
    } else if (data.level.from == data.level.to) {
      level = '${data.level.from}';
    }
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              DefaultMaterialPageRoute(
                builder: (context) => TemtemPage(data: temtem!),
              ));
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 6),
                child: Text(
                  temtem!.name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              TemtemIcon(fileid: temtem!.icon),
              Row(
                children:
                    temtem!.type.map((e) => TemtemTypeIcon(name: e)).toList(),
              ),
              Container(
                padding: const EdgeInsets.only(top: 4, bottom: 4),
                child: Row(
                  children: odds,
                ),
              ),
              Text(level),
            ],
          ),
        ),
      ),
    );
  }

  getTemtem() async {
    try {
      temtem = await api.getTemtem(widget.data.name);
    } finally {
      if (mounted) {
        setState(() {});
      }
    }
  }
}
