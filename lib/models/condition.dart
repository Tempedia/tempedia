import 'package:tempedia/models/temtem.dart';

class TemtemStatusCondition {
  final String name;
  final String icon;
  final String description;
  final String group;
  final List<String> techniques;
  final List<String> traits;

  const TemtemStatusCondition({
    required this.name,
    required this.icon,
    required this.description,
    required this.group,
    required this.techniques,
    required this.traits,
  });

  factory TemtemStatusCondition.fromJson(Map<String, dynamic> json) {
    return TemtemStatusCondition(
      name: json['name'],
      icon: json['icon'],
      description: json['description'],
      group: json['group'],
      techniques: parseListString(json['techniques']),
      traits: parseListString(json['traits']),
    );
  }
}
