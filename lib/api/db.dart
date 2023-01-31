import 'package:tempedia/api/temtem.dart';
import 'package:tempedia/models/db.dart';
import 'package:tempedia/models/temtem.dart';
import 'package:tempedia/models/trait.dart';

const millisecondsOfDay = 1000 * 3600 * 24;

Future<List<TemtemType>> findTemtemTypesWithDB() async {
  List<TemtemType> types = await queryTemtemTypesFromDB();
  final now = DateTime.now().millisecondsSinceEpoch;
  if (types.isNotEmpty && types[0].updatedAt > now - millisecondsOfDay * 7) {
    return types;
  }
  return findTemtemTypes();
}

Future<TemtemTrait> getTemtemTraitWithDB(String name) async {
  TemtemTrait? trait = await getTemtemTraitFromDB(name);
  final now = DateTime.now().millisecondsSinceEpoch;
  if (trait != null && trait.updatedAt > now - millisecondsOfDay * 7) {
    return trait;
  }
  return getTemtemTrait(name);
}

Future<TemtemType> getTemtemTypeWithDB(String name) async {
  TemtemType? type = await getTemtemTypeFromDB(name);
  final now = DateTime.now().millisecondsSinceEpoch;
  if (type != null && type.updatedAt > now - millisecondsOfDay * 7) {
    return type;
  }
  return getTemtemType(name);
}
