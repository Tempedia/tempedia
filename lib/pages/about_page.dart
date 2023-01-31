import 'dart:io';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<StatefulWidget> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        actions: [
          IconButton(
            onPressed: shareApp,
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30),
              alignment: Alignment.center,
              child: Image.asset(
                'assets/image/icon.png',
                width: 160,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: const Text(
                'This app is unofficial. Not created, funded or supported by Crema.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              alignment: Alignment.center,
              child: Image.asset(
                'assets/image/built_with_flutter.png',
                width: 120,
              ),
            ),
          ],
        ),
      ),
    );
  }

  shareApp() async {
    final box = context.findRenderObject() as RenderBox?;
    String text =
        'https://play.google.com/store/apps/details?id=xyz.wikylyu.tempedia';
    if (Platform.isIOS) {
      text = 'Not Found';
    }
    await Share.share(
      text,
      subject: 'Tempedia App',
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }
}
