import 'package:tempedia/env/dev.dart';
import 'package:tempedia/env/prod.dart';

class AdmobConfig {
  final String bannerUnitID;
  final String openUnitID;

  const AdmobConfig({
    required this.bannerUnitID,
    required this.openUnitID,
  });
}

class IAPConfig {
  final String removeAdsProductID;

  const IAPConfig({required this.removeAdsProductID});
}

class Environment {
  final String scheme;
  final String apiHost;
  final int? apiHostPort;
  final String apiPrefix;
  final AdmobConfig admob;
  final IAPConfig iap;

  const Environment({
    required this.scheme,
    required this.apiHost,
    required this.apiHostPort,
    required this.apiPrefix,
    required this.admob,
    required this.iap,
  });
}

// const env = devEnv;
const env = prodEnv;
