import 'package:flutter/material.dart';
import 'package:tempedia/components/temtem/temtem_icon.dart';
import 'package:tempedia/models/team.dart';

class TeamItem extends StatefulWidget {
  final Team data;
  final Function() onTap;

  const TeamItem({super.key, required this.data, required this.onTap});

  @override
  State<StatefulWidget> createState() => _TeamItemState();
}

class _TeamItemState extends State<TeamItem> {
  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    return Card(
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Text(
                  data.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Row(
                children: data.temtems
                    .map(
                      (e) => TemtemIcon(
                        fileid: e.luma ? e.temtem.lumaIcon : e.temtem.icon,
                        size: 40,
                      ),
                    )
                    .toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
