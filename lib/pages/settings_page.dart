import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:tempedia/components/admob/admob_manager.dart';
import 'package:tempedia/env/env.dart';
import 'package:tempedia/models/db.dart' as db;
import 'package:tempedia/pages/about_page.dart';
import 'package:tempedia/pages/theme_select_page.dart';
import 'package:tempedia/utils/transition.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: [
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: const Text('Theme'),
            // subtitle: const Text('change app theme'),
            trailing: Container(
              color: Theme.of(context).primaryColor,
              width: 20,
              height: 20,
            ),
            onTap: () {
              Navigator.push(
                context,
                DefaultMaterialPageRoute(
                    builder: (context) => const ThemeSelectPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.cached),
            title: const Text('Clear Cache'),
            // subtitle: const Text('clear when necessary'),
            onTap: clearCache,
          ),
          AdmobManager.enabled
              ? ListTile(
                  leading: const Icon(Icons.ad_units),
                  title: const Text('Remove Ads'),
                  onTap: removeAds,
                )
              : Container(),
          ListTile(
            leading: const Icon(Icons.contact_support),
            title: const Text('About'),
            // subtitle: const Text('about this app'),
            onTap: () {
              Navigator.push(
                context,
                DefaultMaterialPageRoute(
                    builder: (context) => const AboutPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  clearCache() async {
    final m = DefaultCacheManager();
    await m.emptyCache();
    await db.deleteTemtemTypes();
    Fluttertoast.showToast(msg: 'Cache Cleared');
  }

  removeAds() async {
    final bool available = await InAppPurchase.instance.isAvailable();
    if (!available) {
      Fluttertoast.showToast(msg: 'No Store Found');
      return;
    }
    final Set<String> kIds = <String>{env.iap.removeAdsProductID};
    final ProductDetailsResponse response =
        await InAppPurchase.instance.queryProductDetails(kIds);
    if (response.notFoundIDs.isNotEmpty) {
      Fluttertoast.showToast(msg: 'Product Not Found');
      return;
    }

    await InAppPurchase.instance.restorePurchases();

    List<ProductDetails> products = response.productDetails;
    final PurchaseParam purchaseParam =
        PurchaseParam(productDetails: products[0]);
    await InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam);
  }
}
