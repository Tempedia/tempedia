import 'package:tempedia/api/api.dart';

Future<bool> validateGooglePlayIAP(
    {required String productID, required String token}) async {
  final r = await apiget(
    '/google/play/iap/validate',
    queryParams: {'product_id': productID, 'token': token},
  );
  return r as bool;
}
