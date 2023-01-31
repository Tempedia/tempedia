import 'package:tempedia/api/api.dart';
import 'package:tempedia/models/db.dart';
import 'package:tempedia/models/temtem.dart';
import 'package:tempedia/models/trait.dart';

Future<ApiList<Temtem>> findTemtems({
  String query = '',
  List<String> types = const [],
  String trait = '',
  int page = 1,
  int pageSize = 99,
  bool withTechnique = false,
}) async {
  final data = await apiget(
    '/temtem/temtems',
    queryParams: {
      'query': query,
      'trait': trait,
      'page': '$page',
      'type': types,
      'pageSize': '$pageSize',
      'withTechniques': '$withTechnique',
    },
  );

  return ApiList.fromJson(data, Temtem.fromJson);
}

Future<TemtemType> getTemtemType(String name) async {
  final data = await apiget("/temtem/type/$name");
  return TemtemType.fromJson(data);
}

Future<Temtem> getTemtem(String name) async {
  final data = await apiget("/temtem/temtem/$name");
  return Temtem.fromJson(data);
}

Future<TemtemTrait> getTemtemTrait(String name) async {
  final data = await apiget("/temtem/trait/$name");
  return await TemtemTrait.fromJson(data).save();
}

Future<List<TemtemType>> findTemtemTypes() async {
  final data = await apiget('/temtem/types');
  List<TemtemType> list = [];
  await deleteTemtemTypes();
  for (var t in data) {
    list.add(await TemtemType.fromJson(t).save());
  }
  return list;
}

Future<List<Temtem>> findTemtemEvolvesFrom(String name) async {
  final data = await apiget('/temtem/temtem/$name/evolves_from');
  return (data as List).map((e) => Temtem.fromJson(e)).toList();
}

Future<List<Temtem>> findTemtemsByTrait(String name) async {
  final data = await apiget('/temtem/trait/$name/temtems');
  return (data as List).map((e) => Temtem.fromJson(e)).toList();
}
