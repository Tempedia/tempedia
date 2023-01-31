import 'package:flutter/material.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:flutter_flip_card/flipcard/flip_card.dart';
import 'package:flutter_flip_card/flipcard/gesture_flip_card.dart';
import 'package:flutter_flip_card/modal/flip_side.dart';
import 'package:flutter_shake_animated/flutter_shake_animated.dart';
import 'package:tempedia/components/admob/admob_banner.dart';
import 'package:tempedia/components/custom_gesture_flip_card.dart';
import 'package:tempedia/components/gender_icon.dart';
import 'package:tempedia/components/loading.dart';
import 'package:tempedia/components/team/team_temtem_technique_item.dart';
import 'package:tempedia/components/temtem/temtem_icon.dart';
import 'package:tempedia/components/temtem/temtem_name.dart';
import 'package:tempedia/components/temtem/temtem_no.dart';
import 'package:tempedia/components/temtem/temtem_trait_name.dart';
import 'package:tempedia/components/temtem/temtem_type_icon.dart';
import 'package:tempedia/models/team.dart';
import 'package:collection/collection.dart';
import 'package:tempedia/models/technique.dart';
import 'package:tempedia/pages/team/team_temtem_gender_select_page.dart';
import 'package:tempedia/pages/team/team_temtem_trait_select_page.dart';
import 'package:tempedia/utils/transition.dart';

class TeamTemtemItemPage extends StatefulWidget {
  final TeamTemtem data;
  final int index;
  const TeamTemtemItemPage(
      {super.key, required this.data, required this.index});

  @override
  State<StatefulWidget> createState() => _TeamTemtemItemPageState();
}

class _TeamTemtemItemPageState extends State<TeamTemtemItemPage> {
  final FlipCardController flipController = FlipCardController();

  @override
  void initState() {
    super.initState();
    findTemtemTechniques();
  }

  Widget _createRightTechnique(
      TemtemTechnique technique, bool egg, bool course) {
    final data = widget.data;
    return ShakeWidget(
      shakeConstant: ShakeDefaultConstant1(),
      duration: const Duration(seconds: 5),
      autoPlay: rightSelected == technique.name,
      child: Container(
        height: 42,
        child: TeamTemtemTechniqueItem(
          data: technique,
          egg: egg,
          course: course,
          onTap: () {
            if (rightSelected == technique.name) {
              rightSelected = '';
            } else {
              if (leftSelected.isNotEmpty) {
                for (int i = 0; i < data.techniques.length; i++) {
                  if (data.techniques[i].technique.name == leftSelected) {
                    data.techniques[i] = TeamTemtemTechnique(
                      technique: technique,
                      egg: true,
                      course: false,
                    );
                    break;
                  }
                }
                leftSelected = '';
                rightSelected = '';
              } else {
                rightSelected = technique.name;
              }
            }
            setState(() {});
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;

    Widget iconWidget = TemtemIcon(
      fileid: data.temtem.icon,
      size: 150,
      tag: 'team-${widget.index}',
    );
    Widget lumaWidget = TemtemIcon(
      fileid: data.temtem.lumaIcon,
      size: 150,
      tag: 'team-${widget.index}',
    );

    List<Widget> tChildren = [];
    if (loading) {
      tChildren.add(const Loading());
    } else {
      for (var t in levelingUpTechniques) {
        if (!checkTechnique(t.technique.name)) {
          tChildren.add(
            _createRightTechnique(t.technique, false, false),
          );
        }
      }
      for (var t in courseTechniques) {
        if (!checkTechnique(t.technique.name)) {
          tChildren.add(
            _createRightTechnique(t.technique, false, true),
          );
        }
      }
      for (var t in breedingTechniques) {
        if (!checkTechnique(t.technique.name)) {
          tChildren.add(
            _createRightTechnique(t.technique, true, false),
          );
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Temtem'),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        padding: const EdgeInsets.all(10),
        children: [
          const AdMobBanner(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomGestureFlipCard(
                key: ValueKey(data.luma),
                animationDuration: const Duration(milliseconds: 300),
                axis: FlipAxis.vertical,
                frontWidget: data.luma ? lumaWidget : iconWidget,
                backWidget: data.luma ? iconWidget : lumaWidget,
                callback: (isFront) {
                  if (!isFront) {
                    data.luma = !data.luma;
                    setState(() {});
                  }
                },
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TemtemNO(
                      no: data.temtem.NO(),
                      tag: 'team-${widget.index}',
                      size: 18,
                    ),
                    Row(
                      children: [
                        TemtemName(
                          name: data.temtem.name,
                          tag: 'team-${widget.index}',
                          size: 32,
                        ),
                        InkWell(
                          onTap: () async {
                            if (data.gender.isEmpty ||
                                data.temtem.genderRatio.female <= 0 ||
                                data.temtem.genderRatio.male <= 0) {
                              /* 没有性别或者单一性别 */
                              return;
                            }
                            final gender = await Navigator.push(
                              context,
                              DefaultMaterialPageRoute(
                                builder: (context) =>
                                    const TeamTemtemGenderSelectPage(),
                              ),
                            );
                            setState(() {
                              data.gender = gender;
                            });
                          },
                          child: GenderIcon(
                            gender: data.gender,
                            size: 32,
                            tag: 'team-${widget.index}',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: data.temtem.type
                          .map(
                            (e) => TemtemTypeIcon(
                              name: e,
                              tag: 'team-${widget.index}',
                              size: 36,
                            ),
                          )
                          .toList(),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 6),
                      child: InkWell(
                        onTap: () async {
                          String trait = await Navigator.push(
                            context,
                            DefaultMaterialPageRoute(
                              builder: (context) => TeamTemtemTraitSelectPage(
                                data: widget.data.temtem,
                              ),
                            ),
                          );
                          setState(() {
                            data.trait = trait;
                          });
                        },
                        child: TemtemTraitName(
                          tag: 'team-${widget.index}',
                          width: null,
                          name: data.trait,
                          fontSize: 16,
                          color: data.temtem.traits[0] == data.trait
                              ? const Color(0xFFbce2e3)
                              : const Color(0xFFebd6c2),
                          padding: const EdgeInsets.only(
                              left: 6, right: 6, top: 2, bottom: 2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: data.techniques
                        .mapIndexed(
                          (index, element) => ShakeWidget(
                            shakeConstant: ShakeDefaultConstant1(),
                            duration: const Duration(seconds: 5),
                            autoPlay: leftSelected ==
                                data.techniques[index].technique.name,
                            child: Container(
                              height: 42,
                              child: TeamTemtemTechniqueItem(
                                tag: 'team-${widget.index}-$index',
                                data: data.techniques[index].technique,
                                egg: data.techniques[index].egg,
                                course: data.techniques[index].course,
                                onTap: () {
                                  if (leftSelected ==
                                      data.techniques[index].technique.name) {
                                    leftSelected = '';
                                  } else {
                                    if (leftSelected.isNotEmpty) {
                                      var t = data.techniques[index];
                                      for (var j = 0;
                                          j < data.techniques.length;
                                          j++) {
                                        if (data.techniques[j].technique.name ==
                                            leftSelected) {
                                          data.techniques[index] =
                                              data.techniques[j];
                                          data.techniques[j] = t;
                                          leftSelected = '';
                                          break;
                                        }
                                      }
                                    } else if (rightSelected.isNotEmpty) {
                                      for (var tt in levelingUpTechniques) {
                                        if (tt.technique.name ==
                                            rightSelected) {
                                          data.techniques[index] =
                                              TeamTemtemTechnique(
                                            technique: tt.technique,
                                            egg: false,
                                            course: false,
                                          );
                                          break;
                                        }
                                      }
                                      for (var tt in courseTechniques) {
                                        if (tt.technique.name ==
                                            rightSelected) {
                                          data.techniques[index] =
                                              TeamTemtemTechnique(
                                            technique: tt.technique,
                                            egg: false,
                                            course: true,
                                          );
                                          break;
                                        }
                                      }
                                      for (var tt in breedingTechniques) {
                                        if (tt.technique.name ==
                                            rightSelected) {
                                          data.techniques[index] =
                                              TeamTemtemTechnique(
                                            technique: tt.technique,
                                            egg: true,
                                            course: false,
                                          );
                                          break;
                                        }
                                      }
                                      rightSelected = '';
                                    } else {
                                      leftSelected =
                                          data.techniques[index].technique.name;
                                    }
                                  }
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: tChildren,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // ),
    );
  }

  String leftSelected = '';
  String rightSelected = '';

  bool loading = false;
  List<TemtemLevelingUpTechnique> levelingUpTechniques = [];
  List<TemtemCourseTechnique> courseTechniques = [];
  List<TemtemBreedingTechnique> breedingTechniques = [];
  // List<TeamTemtemTechnique> techniques = [];

  bool checkTechnique(String name) {
    for (var t in widget.data.techniques) {
      if (t.technique.name == name) {
        return true;
      }
    }
    return false;
  }

  findTemtemTechniques() async {
    try {
      // for (var t in widget.data.techniques) {
      //   techniques.add(t);
      // }

      final techniqueGroup = widget.data.temtem.techniqueGroup!;
      levelingUpTechniques = [];
      courseTechniques = [];
      breedingTechniques = [];
      if (widget.data.temtem.subspecie != null) {
        for (var t in techniqueGroup.levelingUp) {
          if (t.group.isNotEmpty &&
              t.group != widget.data.temtem.subspecie!.type) {
            continue;
          }
          levelingUpTechniques.add(t);
        }
      } else {
        for (var t in techniqueGroup.levelingUp) {
          levelingUpTechniques.add(t);
        }
      }
      for (var t in techniqueGroup.course) {
        courseTechniques.add(t);
      }
      for (var t in techniqueGroup.breeding) {
        breedingTechniques.add(t);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Network Error'),
        ),
      );
    }
  }

  // Future<bool> onWillPop() async {
  //   final data = widget.data;
  //   if (luma == data.luma) {
  //     return true;
  //   }
  //   return await showDialog(
  //         //show confirm dialogue
  //         //the return value will be from "Yes" or "No" options
  //         context: context,
  //         builder: (context) => AlertDialog(
  //           title: const Text('Discard Changes'),
  //           content:
  //               const Text('Do you want to exit without saving your changes?'),
  //           actions: [
  //             ElevatedButton(
  //               onPressed: () => Navigator.of(context).pop(false),
  //               //return false when click on "NO"
  //               child: const Text('No'),
  //             ),
  //             ElevatedButton(
  //               onPressed: () => Navigator.of(context).pop(true),
  //               //return true when click on "Yes"
  //               child: const Text('Yes'),
  //             ),
  //           ],
  //         ),
  //       ) ??
  //       false; //i
  // }
}
