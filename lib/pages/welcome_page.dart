import 'package:flutter/material.dart';
import 'package:tempedia/components/admob/admob_open_ad_manager.dart';
import 'package:tempedia/pages/temtem_list_page.dart';
import 'package:tempedia/utils/transition.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<StatefulWidget> createState() => WelcomePageState();
}

class WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 1),
      () => {
        Navigator.pushReplacement(
          context,
          MaterialPageRouteWithFadeTransition(
            builder: (context) => const TemtemListPage(),
            duration: const Duration(milliseconds: 600),
          ),
        )
      },
    );

    AdMobOpenAdManager admobOpenAdManager = AdMobOpenAdManager()..loadAd();
    WidgetsBinding.instance.addObserver(
        AppLifecycleReactor(admobOpenAdManager: admobOpenAdManager));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: Image.asset(
          'assets/image/welcome.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
