import 'package:tempedia/env/env.dart';

const prodEnv = Environment(
  scheme: "https",
  apiHost: 'tempedia.wikylyu.xyz',
  apiHostPort: null,
  apiPrefix: '/api',
  admob: AdmobConfig(
    bannerUnitID: 'ca-app-pub-4213314431418550/1615708386',
    openUnitID: 'ca-app-pub-4213314431418550/1563978741',
  ),
  iap: IAPConfig(
    removeAdsProductID: 'p__remove_ads__',
  ),
);
