import 'package:sprintf/sprintf.dart';
import 'package:sqflite/sql.dart';
import 'package:tempedia/models/db.dart';
import 'package:tempedia/models/technique.dart';

List<String> parseListString(dynamic d) {
  final List<String> l = [];
  if (d is String) {
    for (var t in d.split('|')) {
      if (t.isNotEmpty) {
        l.add(t);
      }
    }
  } else if (d is List) {
    for (var t in d) {
      l.add(t);
    }
  }
  return l;
}

class TemtemDescription {
  final String physicalAppearance;
  final String tempedia;

  TemtemDescription({
    required this.physicalAppearance,
    required this.tempedia,
  });

  factory TemtemDescription.fromJson(Map<String, dynamic> json) {
    return TemtemDescription(
      physicalAppearance: json['Physical Appearance'],
      tempedia: json['Tempedia'],
    );
  }

  Map<String, dynamic> toJson() => {
        'Physical Appearance': physicalAppearance,
        'Tempedia': tempedia,
      };
}

class TemtemGenderRatio {
  final int male;
  final int female;

  TemtemGenderRatio({required this.male, required this.female});

  factory TemtemGenderRatio.fromJson(Map<String, dynamic> json) {
    return TemtemGenderRatio(
      male: json['male'],
      female: json['female'],
    );
  }

  Map<String, dynamic> toJson() => {
        'male': male,
        'female': female,
      };

  String defaultGender() {
    if (male <= 0 && female <= 0) {
      return '';
    }
    if (male >= female) {
      return 'male';
    } else {
      return 'female';
    }
  }
}

class TemtemTVYield {
  final int hp;
  final int sta;
  final int spd;
  final int atk;
  final int def;
  final int spatk;
  final int spdef;

  TemtemTVYield({
    required this.hp,
    required this.sta,
    required this.spd,
    required this.atk,
    required this.def,
    required this.spatk,
    required this.spdef,
  });

  factory TemtemTVYield.fromJson(Map<String, dynamic> json) {
    return TemtemTVYield(
      hp: json['HP'],
      sta: json['STA'],
      spd: json['SPD'],
      atk: json['ATK'],
      def: json['DEF'],
      spatk: json['SPATK'],
      spdef: json['SPDEF'],
    );
  }

  Map<String, dynamic> toJson() => {
        'HP': hp,
        'STA': sta,
        'SPD': spd,
        'ATK': atk,
        'DEF': def,
        'SPATK': spatk,
        'SPDEF': spdef,
      };
}

class TemtemStatRange {
  final int from;
  final int to;

  TemtemStatRange({required this.from, required this.to});

  factory TemtemStatRange.fromJson(Map<String, dynamic> json) {
    return TemtemStatRange(
      from: json['from'],
      to: json['to'],
    );
  }

  Map<String, dynamic> toJson() => {
        'from': from,
        'to': to,
      };
}

class TemtemStat {
  final int base;
  final TemtemStatRange l50;
  final TemtemStatRange l100;

  TemtemStat({required this.base, required this.l50, required this.l100});

  factory TemtemStat.fromJson(Map<String, dynamic> json) {
    return TemtemStat(
      base: json['base'],
      l50: TemtemStatRange.fromJson(json['50']),
      l100: TemtemStatRange.fromJson(json['100']),
    );
  }

  Map<String, dynamic> toJson() => {
        'base': base,
        '50': l50.toJson(),
        '100': l100.toJson(),
      };
}

class TemtemStats {
  final TemtemStat hp;
  final TemtemStat sta;
  final TemtemStat spd;
  final TemtemStat atk;
  final TemtemStat def;
  final TemtemStat spatk;
  final TemtemStat spdef;

  TemtemStats({
    required this.hp,
    required this.sta,
    required this.spd,
    required this.atk,
    required this.def,
    required this.spatk,
    required this.spdef,
  });

  factory TemtemStats.fromJson(Map<String, dynamic> json) {
    return TemtemStats(
      hp: TemtemStat.fromJson(json['HP']),
      sta: TemtemStat.fromJson(json['STA']),
      spd: TemtemStat.fromJson(json['SPD']),
      atk: TemtemStat.fromJson(json['ATK']),
      def: TemtemStat.fromJson(json['DEF']),
      spatk: TemtemStat.fromJson(json['SPATK']),
      spdef: TemtemStat.fromJson(json['SPDEF']),
    );
  }

  Map<String, dynamic> toJson() => {
        'HP': hp.toJson(),
        'STA': sta.toJson(),
        'SPD': spd.toJson(),
        'ATK': atk.toJson(),
        'DEF': def.toJson(),
        'SPATK': spatk.toJson(),
        'SPDEF': spdef.toJson(),
      };
}

class GalleryImage {
  final String text;
  final String fileid;
  final String group;

  GalleryImage({required this.text, required this.fileid, required this.group});

  factory GalleryImage.fromJson(Map<String, dynamic> json) {
    return GalleryImage(
      fileid: json['fileid'],
      text: json['text'] ?? '',
      group: json['group'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'fileid': fileid,
        'text': text,
        'group': group,
      };
}

class TemtemEvolvesTo {
  final String to;
  final String method;
  final int level;
  final String gender;
  final String place;
  final int tv;

  TemtemEvolvesTo({
    required this.to,
    required this.method,
    required this.level,
    required this.gender,
    required this.place,
    required this.tv,
  });

  factory TemtemEvolvesTo.fromJson(Map<String, dynamic> json) {
    return TemtemEvolvesTo(
      to: json['to'],
      method: json['method'],
      level: json['level'] ?? 0,
      gender: json['gender'] ?? '',
      place: json['place'] ?? '',
      tv: json['tv'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'to': to,
        'method': method,
        'level': level,
        'gender': gender,
        'place': place,
        'tv': tv,
      };
}

class TemtemSubspecie {
  final String type;
  final String icon;
  final String lumaIcon;

  TemtemSubspecie(
      {required this.type, required this.icon, required this.lumaIcon});

  factory TemtemSubspecie.fromJson(Map<String, dynamic> json) {
    return TemtemSubspecie(
      type: json['type'],
      icon: json['icon'],
      lumaIcon: json['luma_icon'],
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'icon': icon,
        'luma_icon': lumaIcon,
      };
}

class Temtem {
  final int no;
  final String name;
  final String icon;
  final String lumaIcon;
  final List<String> type;
  final List<String> traits;
  final TemtemDescription description;
  final String cry;
  final double height;
  final double weight;
  final TemtemGenderRatio genderRatio;
  final TemtemTVYield tvYield;
  final TemtemStats stats;
  final List<Map<String, dynamic>> typeMatchup;
  final List<GalleryImage> gallery;
  final List<GalleryImage> renders;
  final List<TemtemEvolvesTo> evolvesTo;
  final List<TemtemSubspecie> subspecies;
  final TemtemSubspecie? subspecie;
  final TemtemTechniqueGroup? techniqueGroup;

  const Temtem({
    required this.no,
    required this.name,
    required this.icon,
    required this.lumaIcon,
    required this.type,
    required this.traits,
    required this.description,
    required this.cry,
    required this.height,
    required this.weight,
    required this.genderRatio,
    required this.tvYield,
    required this.stats,
    required this.typeMatchup,
    required this.gallery,
    required this.renders,
    required this.evolvesTo,
    required this.subspecies,
    this.subspecie,
    this.techniqueGroup,
  });

  String NO() {
    return sprintf('%03d', [no]);
  }

  factory Temtem.fromJson(Map<String, dynamic> json) {
    return Temtem(
      no: json['no'],
      name: json['name'],
      icon: json['icon'],
      lumaIcon: json['luma_icon'],
      type: parseListString(json['type']),
      traits: parseListString(json['traits']),
      description: TemtemDescription.fromJson(json['description']),
      cry: json['cry'],
      height: json['height'].toDouble(),
      weight: json['weight'].toDouble(),
      genderRatio: TemtemGenderRatio.fromJson(json['gender_ratio']),
      tvYield: TemtemTVYield.fromJson(json['tv_yield']),
      stats: TemtemStats.fromJson(json['stats']),
      typeMatchup: (json['type_matchup'] as List)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      gallery: (json['gallery'] as List)
          .map((e) => GalleryImage.fromJson(e))
          .toList(),
      renders: (json['renders'] as List)
          .map((e) => GalleryImage.fromJson(e))
          .toList(),
      evolvesTo: (json['evolves_to'] as List)
          .map((e) => TemtemEvolvesTo.fromJson(e))
          .toList(),
      subspecies: (json['subspecies'] as List)
          .map((e) => TemtemSubspecie.fromJson(e))
          .toList(),
      subspecie: json['subspecie'] != null
          ? TemtemSubspecie.fromJson(json['subspecie'])
          : null,
      techniqueGroup: json['techniques'] != null
          ? TemtemTechniqueGroup.fromJson(json['techniques'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'no': no,
        'name': name,
        'icon': icon,
        'luma_icon': lumaIcon,
        'type': type,
        'traits': traits,
        'description': description.toJson(),
        'cry': cry,
        'height': height,
        'weight': weight,
        'gender_ratio': genderRatio.toJson(),
        'tv_yield': tvYield.toJson(),
        'stats': stats.toJson(),
        'type_matchup': typeMatchup,
        'gallery': gallery.map((e) => e.toJson()).toList(),
        'renders': renders.map((e) => e.toJson()).toList(),
        'evolves_to': evolvesTo.map((e) => e.toJson()).toList(),
        'subspecies': subspecies.map((e) => e.toJson()).toList(),
        'subspecie': subspecie?.toJson(),
        'techniques': techniqueGroup?.toJson()
      };
}

class TemtemType {
  final String name;
  final String icon;
  final String comment;
  final List<String> effectiveAgainst;
  final List<String> ineffectiveAgainst;
  final List<String> resistantTo;
  final List<String> weakTo;
  final int sort;
  final String color;
  final int updatedAt;

  const TemtemType({
    required this.name,
    required this.icon,
    required this.sort,
    required this.comment,
    required this.effectiveAgainst,
    required this.ineffectiveAgainst,
    required this.resistantTo,
    required this.weakTo,
    required this.updatedAt,
    required this.color,
  });

  factory TemtemType.fromJson(Map<String, dynamic> json) {
    return TemtemType(
      name: json['name'],
      icon: json['icon'],
      sort: json['sort'],
      comment: json['comment'],
      updatedAt: json['updated_at'] ?? 0,
      effectiveAgainst: parseListString(json['effective_against']),
      ineffectiveAgainst: parseListString(json['ineffective_against']),
      resistantTo: parseListString(json['resistant_to']),
      weakTo: parseListString(json['weak_to']),
      color: json['color'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'icon': icon,
      'comment': comment,
      'sort': sort,
      'effective_against': effectiveAgainst.join('|'),
      'ineffective_against': ineffectiveAgainst.join('|'),
      'resistant_to': resistantTo.join('|'),
      'weak_to': weakTo.join('|'),
      'updated_at': DateTime.now().millisecondsSinceEpoch,
      'color': color,
    };
  }

  save() async {
    final db = await sqlitedb;

    await db.insert(
      tableTemtemType,
      toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return this;
  }
}
