import 'package:tempedia/api/api.dart';
import 'package:tempedia/models/trait.dart';

Future<ApiList<TemtemTrait>> findTemtemTraits(
    {query = '', page = 1, pageSize = 10}) async {
  final data = await apiget('/temtem/traits',
      queryParams: {'query': query, 'page': '$page', 'pageSize': '$pageSize'});

  return ApiList<TemtemTrait>.fromJson(data, TemtemTrait.fromJson);
}
