import 'package:sqflite/sql.dart';
import 'package:tempedia/models/db.dart';

class TemtemTrait {
  final String name;
  final String description;
  final String impact;
  final String effect;
  final String trigger;
  final int updatedAt;

  TemtemTrait({
    required this.name,
    required this.description,
    required this.impact,
    required this.effect,
    required this.trigger,
    required this.updatedAt,
  });

  factory TemtemTrait.fromJson(Map<String, dynamic> json) {
    return TemtemTrait(
      name: json['name'],
      description: json['description'],
      impact: json['impact'],
      trigger: json['trigger'],
      effect: json['effect'],
      updatedAt: json['updated_at'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'impact': impact,
      'trigger': trigger,
      'effect': effect,
      'updated_at': DateTime.now().millisecondsSinceEpoch,
    };
  }

  save() async {
    final db = await sqlitedb;

    await db.insert(
      tableTemtemTrait,
      toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return this;
  }
}
