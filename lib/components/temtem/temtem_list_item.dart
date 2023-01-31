import 'package:flutter/material.dart';
import 'package:tempedia/components/temtem/temtem_icon.dart';
import 'package:tempedia/components/temtem/temtem_name.dart';
import 'package:tempedia/components/temtem/temtem_no.dart';
import 'package:tempedia/components/temtem/temtem_type_icon.dart';
import 'package:tempedia/models/temtem.dart';

class TemtemListItem extends StatelessWidget {
  final Temtem data;
  final Function()? onTap;

  const TemtemListItem({super.key, required this.data, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TemtemIcon(
                fileid: data.icon,
                size: 64,
                tag: "temtem",
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 16),
                  constraints: const BoxConstraints(maxHeight: double.infinity),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TemtemNO(
                        no: data.NO(),
                        size: 14,
                        tag: 'temtem',
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 1, bottom: 2),
                        child: TemtemName(
                          name: data.name,
                          size: 22,
                          tag: 'temtem-name',
                        ),
                      ),
                      Hero(
                        tag: data.description.tempedia,
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            data.description.tempedia,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: data.type
                    .map(
                      (e) => TemtemTypeIcon(
                        name: e,
                        size: 36,
                        tag: data.name,
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
