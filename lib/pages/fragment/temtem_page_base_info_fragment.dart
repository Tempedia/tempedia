import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:tempedia/components/admob/admob_banner.dart';
import 'package:tempedia/components/divider_with_text.dart';
import 'package:tempedia/components/gender_ratio_bar.dart';
import 'package:tempedia/components/temtem/temtem_icon.dart';
import 'package:tempedia/components/temtem/temtem_name.dart';
import 'package:tempedia/components/temtem/temtem_no.dart';
import 'package:tempedia/components/temtem/temtem_trait_card.dart';
import 'package:tempedia/components/temtem/temtem_type_icon.dart';
import 'package:tempedia/components/text_tag.dart';
import 'package:tempedia/components/tv_yield_tags.dart';
import 'package:tempedia/components/voice_player.dart';
import 'package:tempedia/models/temtem.dart';
import 'package:tempedia/pages/temtem_type_matchup_page.dart';
import 'package:tempedia/utils/transition.dart';

class TemtemPageBaseInfoFragment extends StatefulWidget {
  final Temtem data;

  const TemtemPageBaseInfoFragment({super.key, required this.data});

  @override
  State<StatefulWidget> createState() => _TemtemPageBaseInfoFragmentState();
}

class _TemtemPageBaseInfoFragmentState extends State<TemtemPageBaseInfoFragment>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final data = widget.data;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const AdMobBanner(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    GestureFlipCard(
                      animationDuration: const Duration(milliseconds: 300),
                      axis: FlipAxis.vertical,
                      frontWidget: Center(
                        child: TemtemIcon(
                          fileid: data.icon,
                          size: 160,
                          tag: "temtem",
                          tappable: true,
                        ),
                      ),
                      backWidget: TemtemIcon(
                        fileid: data.lumaIcon,
                        size: 160,
                        tappable: true,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      child: TextTag(
                        text: '${data.height}cm/${data.weight}kg',
                      ),
                    ),
                  ],
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.only(left: 14),
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            TemtemNO(
                              no: data.NO(),
                              size: 18,
                              tag: 'temtem',
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: VoicePlayer(
                                fileid: data.cry,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                        TemtemName(
                          name: data.name,
                          size: 36,
                          tag: 'temtem-name',
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
                        Container(
                          margin: const EdgeInsets.only(top: 6),
                          child: GenderRatioBar(
                            male: data.genderRatio.male,
                            female: data.genderRatio.female,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: TVYieldTags(tvYield: data.tvYield),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Hero(
                tag: data.description.tempedia,
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    data.description.tempedia,
                    // overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      // fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              alignment: Alignment.centerRight,
              child: const Text('--Tempedia'),
            ),
            const DividerWithText(text: "Traits"),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: data.traits
                  .map(
                    (e) => TemtemTraitCard(name: e),
                  )
                  .toList(),
            ),
            const DividerWithText(text: "Type Matchup"),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  DefaultMaterialPageRoute(
                    builder: (context) => TemtemTypeMatchupPage(data: data),
                  ),
                );
              },
              icon: const Icon(
                Icons.stay_current_landscape_outlined,
                size: 24.0,
              ),
              label: const Text('View Type Matchup'), // <-- Text
            ),
          ],
        ),
      ),
    );
  }
}
