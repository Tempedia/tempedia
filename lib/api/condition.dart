import 'package:tempedia/api/api.dart';
import 'package:tempedia/models/condition.dart';
import 'package:tempedia/models/technique.dart';
import 'package:tempedia/models/trait.dart';

Future<ApiList<TemtemStatusCondition>> findTemtemStatusConditions(
    {query = '', group = '', page = 1, pageSize = 20}) async {
  final r = await apiget('/temtem/status/conditions', queryParams: {
    'query': query,
    'group': group,
    'page': '$page',
    'pageSize': '$pageSize'
  });
  return ApiList.fromJson(r, TemtemStatusCondition.fromJson);
}

Future<List<TemtemTechnique>> findTemtemStatusConditionTechniques(
    String name) async {
  final r = await apiget('/temtem/status/condition/$name/techniques');
  return (r as List).map((e) => TemtemTechnique.fromJson(e)).toList();
}

Future<List<TemtemTrait>> findTemtemStatusConditionTraits(String name) async {
  final r = await apiget('/temtem/status/condition/$name/traits');
  return (r as List).map((e) => TemtemTrait.fromJson(e)).toList();
}
