import 'package:tempedia/models/temtem.dart';

class TemtemTechnique {
  final String name;
  final String type;
  final String cls;
  final int damage;
  final int staCost;
  final int hold;
  final int priority;
  final String targeting;
  final String description;
  final String video;

  final String synergyType;
  final String synergyDescription;
  final String synergyEffects;
  final int synergyDamage;
  final int synergySTACost;
  final int synergyPriority;
  final String synergyTargeting;
  final String synergyVideo;

  TemtemTechnique({
    required this.name,
    required this.type,
    required this.cls,
    required this.damage,
    required this.staCost,
    required this.hold,
    required this.priority,
    required this.targeting,
    required this.description,
    required this.video,
    required this.synergyType,
    required this.synergyDescription,
    required this.synergyEffects,
    required this.synergyDamage,
    required this.synergySTACost,
    required this.synergyPriority,
    required this.synergyTargeting,
    required this.synergyVideo,
  });

  factory TemtemTechnique.fromJson(Map<String, dynamic> json) {
    return TemtemTechnique(
      name: json['name'],
      type: json['type'],
      cls: json['class'],
      damage: json['damage'],
      staCost: json['sta_cost'],
      hold: json['hold'],
      priority: json['priority'],
      targeting: json['targeting'],
      description: json['description'],
      video: json['video'],
      synergyType: json['synergy_type'],
      synergyDescription: json['synergy_description'],
      synergyEffects: json['synergy_effects'],
      synergyDamage: json['synergy_damage'],
      synergySTACost: json['synergy_sta_cost'],
      synergyPriority: json['synergy_priority'],
      synergyTargeting: json['synergy_targeting'],
      synergyVideo: json['synergy_video'],
    );
  }

  String damageStr() {
    if (damage >= 0) {
      return '$damage';
    }
    return '-';
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'type': type,
        'class': cls,
        'damage': damage,
        'sta_cost': staCost,
        'hold': hold,
        'priority': priority,
        'targeting': targeting,
        'description': description,
        'video': video,
        'synergy_type': synergyType,
        'synergy_description': synergyDescription,
        'synergy_effects': synergyEffects,
        'synergy_damage': synergyDamage,
        'synergy_sta_cost': synergySTACost,
        'synergy_priority': synergyPriority,
        'synergy_targeting': synergyTargeting,
        'synergy_video': synergyVideo,
      };
}

class TemtemCourseItem {
  final String no;
  final String source;
  final TemtemTechnique technique;

  TemtemCourseItem({
    required this.no,
    required this.source,
    required this.technique,
  });

  factory TemtemCourseItem.fromJson(Map<String, dynamic> json) {
    return TemtemCourseItem(
      no: json['no'],
      source: json['source'],
      technique: TemtemTechnique.fromJson(json['technique']),
    );
  }
}

class TemtemTechqniueBase {
  final TemtemTechnique technique;
  final Temtem? temtem;
  final bool stab;

  TemtemTechqniueBase(
      {required this.stab, required this.technique, this.temtem});
}

class TemtemLevelingUpTechnique extends TemtemTechqniueBase {
  final int level;
  final String group;

  TemtemLevelingUpTechnique({
    required super.stab,
    required super.technique,
    required this.level,
    required this.group,
    super.temtem,
  });

  factory TemtemLevelingUpTechnique.fromJson(Map<String, dynamic> json) {
    return TemtemLevelingUpTechnique(
      stab: json['stab'],
      level: json['level'],
      group: json['group'],
      technique: TemtemTechnique.fromJson(json['technique']),
      temtem: json['temtem'] != null ? Temtem.fromJson(json['temtem']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'stab': stab,
        'level': level,
        'group': group,
        'technique': technique.toJson(),
        'temtem': temtem?.toJson(),
      };
}

class TemtemCourseTechnique extends TemtemTechqniueBase {
  final String course;

  TemtemCourseTechnique({
    required super.stab,
    required this.course,
    required super.technique,
    super.temtem,
  });

  factory TemtemCourseTechnique.fromJson(Map<String, dynamic> json) {
    return TemtemCourseTechnique(
      stab: json['stab'],
      course: json['course'],
      technique: TemtemTechnique.fromJson(json['technique']),
      temtem: json['temtem'] != null ? Temtem.fromJson(json['temtem']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'course': course,
        'stab': stab,
        'technique': technique.toJson(),
        'temtem': temtem?.toJson(),
      };
}

class TemtemBreedingTechniqueParent {
  final String name;
  final String hint;
  TemtemBreedingTechniqueParent({required this.name, required this.hint});

  factory TemtemBreedingTechniqueParent.fromJson(Map<String, dynamic> json) {
    return TemtemBreedingTechniqueParent(
        name: json['name'], hint: json['hint']);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'hint': hint,
      };
}

class TemtemBreedingTechnique extends TemtemTechqniueBase {
  final List<TemtemBreedingTechniqueParent> parents;

  TemtemBreedingTechnique({
    required super.stab,
    required super.technique,
    required this.parents,
    super.temtem,
  });

  factory TemtemBreedingTechnique.fromJson(Map<String, dynamic> json) {
    return TemtemBreedingTechnique(
      stab: json['stab'],
      parents: (json['parents'] as List<dynamic>)
          .map((e) => TemtemBreedingTechniqueParent.fromJson(e))
          .toList(),
      technique: TemtemTechnique.fromJson(json['technique']),
      temtem: json['temtem'] != null ? Temtem.fromJson(json['temtem']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'parents': parents.map((e) => e.toJson()).toList(),
        'stab': stab,
        'technique': technique.toJson(),
        'temtem': temtem?.toJson(),
      };
}

class TemtemTechniqueGroup {
  final List<TemtemLevelingUpTechnique> levelingUp;
  final List<TemtemCourseTechnique> course;
  final List<TemtemBreedingTechnique> breeding;

  TemtemTechniqueGroup({
    required this.levelingUp,
    required this.course,
    required this.breeding,
  });

  factory TemtemTechniqueGroup.fromJson(Map<String, dynamic> json) {
    return TemtemTechniqueGroup(
      levelingUp: (json['leveling_up'] as List<dynamic>)
          .map((e) => TemtemLevelingUpTechnique.fromJson(e))
          .toList(),
      course: (json['course'] as List<dynamic>)
          .map((e) => TemtemCourseTechnique.fromJson(e))
          .toList(),
      breeding: (json['breeding'] as List<dynamic>)
          .map((e) => TemtemBreedingTechnique.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'leveling_up': levelingUp.map((e) => e.toJson()).toList(),
        'course': course.map((e) => e.toJson()).toList(),
        'breeding': breeding.map((e) => e.toJson()).toList(),
      };
}
