import 'package:tempedia/api/api.dart';
import 'package:tempedia/models/condition.dart';
import 'package:tempedia/models/location.dart';
import 'package:tempedia/models/technique.dart';
import 'package:tempedia/models/temtem.dart';
import 'package:tempedia/models/trait.dart';

class SearchResult {
  final List<Temtem> temtems;
  final List<TemtemTechnique> techniques;
  final List<TemtemStatusCondition> conditions;
  final List<TemtemTrait> traits;
  final List<TemtemLocation> locations;

  SearchResult({
    this.temtems = const [],
    this.techniques = const [],
    this.conditions = const [],
    this.traits = const [],
    this.locations = const [],
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      temtems:
          (json['temtems'] as List).map((e) => Temtem.fromJson(e)).toList(),
      techniques: (json['techniques'] as List)
          .map((e) => TemtemTechnique.fromJson(e))
          .toList(),
      conditions: (json['conditions'] as List)
          .map((e) => TemtemStatusCondition.fromJson(e))
          .toList(),
      traits:
          (json['traits'] as List).map((e) => TemtemTrait.fromJson(e)).toList(),
      locations: (json['locations'] as List)
          .map((e) => TemtemLocation.fromJson(e))
          .toList(),
    );
  }
}

Future<SearchResult> search(String query) async {
  if (query.trim().isEmpty) {
    return SearchResult(
        temtems: [], techniques: [], conditions: [], traits: [], locations: []);
  }
  final r = await apiget('/temtem/search', queryParams: {'query': query});
  return SearchResult.fromJson(r);
}
