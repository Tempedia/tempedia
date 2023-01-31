import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tempedia/env/env.dart';
import 'package:tempedia/components/admob/admob_manager.dart';

class AdMobBanner extends StatefulWidget {
  const AdMobBanner({super.key});

  @override
  State<StatefulWidget> createState() => _AdMobBannerState();
}

class _AdMobBannerState extends State<AdMobBanner> {
  BannerAd? adBanner;

  @override
  void initState() {
    super.initState();

    if (AdmobManager.enabled) {
      adBanner = BannerAd(
        adUnitId: env.admob.bannerUnitID,
        size: AdSize.fullBanner,
        request: const AdRequest(
          keywords: ["temtem", "pokemon", "game"],
        ),
        listener: const BannerAdListener(),
      );

      adBanner?.load();
    }
  }

  @override
  void dispose() {
    adBanner?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (adBanner == null) {
      return Container();
    }
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 10),
      alignment: Alignment.center,
      height: adBanner!.size.height.toDouble(),
      child: AdWidget(ad: adBanner!),
    );
  }
}
