import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tempedia/env/env.dart';
import 'package:tempedia/components/admob/admob_manager.dart';

class AdMobOpenAdManager {
  String adUnitId = env.admob.openUnitID;

  AppOpenAd? _appOpenAd;
  bool _isShowingAd = false;

  void loadAd() {
    if (!AdmobManager.enabled) {
      return;
    }
    AppOpenAd.load(
      adUnitId: adUnitId,
      orientation: AppOpenAd.orientationPortrait,
      request: const AdRequest(
        keywords: ["temtem", "pokemon", "game"],
      ),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          print('AppOpenAd loaded');
          _appOpenAd = ad;
        },
        onAdFailedToLoad: (error) {
          print('AppOpenAd failed to load: $error');
        },
      ),
    );
  }

  /// Whether an ad is available to be shown.
  bool get isAdAvailable {
    return _appOpenAd != null;
  }

  void showAdIfAvailable() {
    if (!AdmobManager.enabled) {
      return;
    }
    if (!isAdAvailable) {
      print('Tried to show ad before available.');
      loadAd();
      return;
    }
    if (_isShowingAd) {
      print('Tried to show ad while already showing an ad.');
      return;
    }
    // Set the fullScreenContentCallback and show the ad.
    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _isShowingAd = true;
        print('$ad onAdShowedFullScreenContent');
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
      },
      onAdDismissedFullScreenContent: (ad) {
        print('$ad onAdDismissedFullScreenContent');
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        loadAd();
      },
    );
    _appOpenAd!.show();
  }
}

class AppLifecycleReactor extends WidgetsBindingObserver {
  final AdMobOpenAdManager admobOpenAdManager;

  AppLifecycleReactor({required this.admobOpenAdManager});

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    // Try to show an app open ad if the app is being resumed and
    // we're not already showing an app open ad.
    print(state);
    if (state == AppLifecycleState.resumed) {
      admobOpenAdManager.showAdIfAvailable();
    }
  }
}
