import 'package:tempedia/api/api.dart';
import 'package:tempedia/models/technique.dart';
import 'package:tempedia/models/temtem.dart';

Future<TemtemTechniqueGroup> findTemtemTechniquesByTemtem(String name) async {
  final data = await apiget("/temtem/temtem/$name/techniques");
  return TemtemTechniqueGroup.fromJson(data);
}

Future<ApiList<TemtemTechnique>> findTemtemTechniques({
  String query = '',
  List<String> types = const [],
  String cls = '',
  int page = 1,
  int pageSize = 20,
}) async {
  final data = await apiget("/temtem/techniques", queryParams: {
    'query': query,
    'page': '$page',
    'pageSize': '$pageSize',
    'type': types,
    'class': cls,
  });
  return ApiList.fromJson(data, TemtemTechnique.fromJson);
}

class TemtemsByTechnique {
  final List<TemtemLevelingUpTechnique> levelingUp;
  final List<TemtemCourseTechnique> course;
  final List<TemtemBreedingTechnique> breeding;

  TemtemsByTechnique(
      {required this.levelingUp, required this.course, required this.breeding});

  factory TemtemsByTechnique.fromJson(Map<String, dynamic> json) {
    return TemtemsByTechnique(
      levelingUp: (json['leveling_up'] as List)
          .map((e) => TemtemLevelingUpTechnique.fromJson(e))
          .toList(),
      course: (json['course'] as List)
          .map((e) => TemtemCourseTechnique.fromJson(e))
          .toList(),
      breeding: (json['breeding'] as List)
          .map((e) => TemtemBreedingTechnique.fromJson(e))
          .toList(),
    );
  }
}

Future<TemtemsByTechnique> findTemtemsByTechnique(String name) async {
  final data = await apiget('/temtem/technique/$name/temtems');
  return TemtemsByTechnique.fromJson(data);
}

Future<ApiList<TemtemCourseItem>> findTemtemTechniqueCourses(
    {String query = '', int page = 1, int pageSize = 10}) async {
  final data = await apiget(
    '/temtem/technique/course/items',
    queryParams: {
      'query': query,
      'page': '$page',
      'pageSize': '$pageSize',
    },
  );
  return ApiList.fromJson(data, TemtemCourseItem.fromJson);
}
