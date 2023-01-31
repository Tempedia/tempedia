import 'package:flutter/material.dart';
import 'package:tempedia/components/temtem/temtem_icon.dart';
import 'package:tempedia/components/temtem/temtem_no.dart';
import 'package:tempedia/components/temtem/temtem_trait_name.dart';
import 'package:tempedia/components/temtem/temtem_type_icon.dart';
import 'package:tempedia/models/temtem.dart';

class TeamTemtemSelectListItem extends StatelessWidget {
  final Temtem data;
  final Function()? onTap;

  const TeamTemtemSelectListItem({super.key, required this.data, this.onTap});

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
                size: 48,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 16),
                  // constraints: const BoxConstraints(maxHeight: double.infinity),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TemtemNO(
                        no: data.NO(),
                        size: 14,
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 1, bottom: 2),
                        child: Text(
                          data.name,
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                      // Row(
                      //   children: [
                      //     SizedBox(
                      //       width: 100,
                      //       child: TemtemTraitName(
                      //         name: data.traits[0],
                      //         color: const Color(0xFFbce2e3),
                      //       ),
                      //     ),
                      //     Container(
                      //       margin: const EdgeInsets.only(left: 10),
                      //       width: 100,
                      //       child: TemtemTraitName(
                      //         name: data.traits[1],
                      //         color: const Color(0xFFebd6c2),
                      //       ),
                      //     ),
                      //   ],
                      // ),
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
