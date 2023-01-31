import 'package:flutter/material.dart';
import 'package:tempedia/components/gender_icon.dart';
import 'package:tempedia/components/team/team_temtem_technique_item.dart';
import 'package:tempedia/components/temtem/temtem_icon.dart';
import 'package:tempedia/components/temtem/temtem_name.dart';
import 'package:tempedia/components/temtem/temtem_no.dart';
import 'package:tempedia/components/temtem/temtem_trait_name.dart';
import 'package:tempedia/components/temtem/temtem_type_icon.dart';
import 'package:tempedia/models/team.dart';
import 'package:tempedia/pages/team/team_temtem_item_page.dart';
import 'package:tempedia/utils/transition.dart';

class TeamTemtemItem extends StatefulWidget {
  final int index;
  final TeamTemtem data;

  const TeamTemtemItem({super.key, required this.data, required this.index});

  @override
  State<StatefulWidget> createState() => _TeamTemtemItemState();
}

class _TeamTemtemItemState extends State<TeamTemtemItem> {
  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    return Card(
      child: Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 6, right: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRouteWithFadeTransition(
                    builder: (context) => TeamTemtemItemPage(
                      data: data,
                      index: widget.index,
                    ),
                  ),
                );
                setState(() {});
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TemtemIcon(
                    fileid: data.luma ? data.temtem.lumaIcon : data.temtem.icon,
                    size: 90,
                    tag: 'team-${widget.index}',
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 6),
                            child: TemtemNO(
                              no: data.temtem.NO(),
                              tag: 'team-${widget.index}',
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            child: Row(
                              children: [
                                TemtemName(
                                  name: data.temtem.name,
                                  tag: 'team-${widget.index}',
                                ),
                                GenderIcon(
                                  gender: data.gender,
                                  size: 22,
                                  tag: 'team-${widget.index}',
                                ),
                              ],
                            ),
                          ),
                          TemtemTraitName(
                            tag: 'team-${widget.index}',
                            width: null,
                            name: data.trait,
                            color: data.temtem.traits[0] == data.trait
                                ? const Color(0xFFbce2e3)
                                : const Color(0xFFebd6c2),
                            padding: const EdgeInsets.only(
                                left: 6, right: 6, top: 2, bottom: 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 6, right: 0),
                    child: Row(
                      children: data.temtem.type
                          .map(
                            (e) => TemtemTypeIcon(
                              name: e,
                              tag: 'team-${widget.index}',
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              height: 10,
            ),
            GridView.builder(
              // Create a grid with 2 columns. If you change the scrollDirection to
              // horizontal, this produces 2 rows.
              primary: false,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.techniques.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                ///横轴元素个数
                crossAxisCount: 2,

                ///纵轴间距

                mainAxisSpacing: 5,

                ///横轴间距

                crossAxisSpacing: 5,

                ///子组件宽高长度比例
                mainAxisExtent: 42,
                // childAspectRatio: 1,
              ),
              itemBuilder: (context, index) => TeamTemtemTechniqueItem(
                tag: 'team-${widget.index}-$index',
                data: data.techniques[index].technique,
                egg: data.techniques[index].egg,
                course: data.techniques[index].course,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class _TemtemTraitName extends StatelessWidget {
//   final String name;
//   final Color color;
//   const _TemtemTraitName({
//     super.key,
//     required this.name,
//     this.color = const Color(0xFFbce2e3),
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: const BorderRadius.all(Radius.circular(1)),
//         color: color,
//       ),
//       padding: const EdgeInsets.only(left: 6, right: 6, bottom: 2, top: 2),
//       margin: const EdgeInsets.only(top: 6),
//       child: Text(
//         name,
//         textAlign: TextAlign.center,
//         style: const TextStyle(
//           fontSize: 12,
//           color: Color(0xFF78617a),
//           // overflow: TextOverflow.ellipsis,
//         ),
//       ),
//     );
//   }
// }
