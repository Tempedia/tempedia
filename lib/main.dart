import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:provider/provider.dart';
import 'package:tempedia/api/google.dart' as api;
import 'package:tempedia/env/env.dart';
import 'package:tempedia/models/db.dart';
import 'package:tempedia/pages/welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tempedia/themes/theme_manager.dart';
import 'package:tempedia/components/admob/admob_manager.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await initialDatabase();

  if (kReleaseMode) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  await ThemeManager.init();
  await AdmobManager.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription<List<PurchaseDetails>>? _subscription;

  @override
  void initState() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        InAppPurchase.instance.purchaseStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription?.cancel();
    }, onError: (error) {
      // handle error here.
    });
    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (var purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          if (purchaseDetails.productID == env.iap.removeAdsProductID) {
            bool purchased = false;
            try {
              if (Platform.isAndroid) {
                purchased = await api.validateGooglePlayIAP(
                    productID: env.iap.removeAdsProductID,
                    token: purchaseDetails
                        .verificationData.serverVerificationData);
              } else if (Platform.isIOS) {
                /* TODO */
              }
            } catch (e) {
              Fluttertoast.showToast(msg: 'Purchase Failed - Network Error');
            }
            if (purchased) {
              AdmobManager.removeAds();
            }
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await InAppPurchase.instance.completePurchase(purchaseDetails);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeManager(),
      child: Consumer<ThemeManager>(
          builder: (context, ThemeManager themeNotifier, child) {
        return MaterialApp(
          title: 'Tempedia',
          theme: themeNotifier.theme,
          home: const WelcomePage(),
        );
      }),
    );
  }
}
