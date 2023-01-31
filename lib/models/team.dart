import 'package:tempedia/models/technique.dart';
import 'package:tempedia/models/temtem.dart';

class TeamTemtemTechnique {
  final TemtemTechnique technique;
  final bool egg;
  final bool course;

  const TeamTemtemTechnique({
    required this.technique,
    required this.egg,
    required this.course,
  });

  factory TeamTemtemTechnique.fromJson(Map<String, dynamic> json) {
    return TeamTemtemTechnique(
      technique: TemtemTechnique.fromJson(json['technique']),
      egg: json['egg'] as bool,
      course: json['course'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
        'technique': technique.toJson(),
        'egg': egg,
        'course': course,
      };
}

class TeamTemtem {
  final Temtem temtem;
  bool luma;
  String trait;
  String gender;

  List<TeamTemtemTechnique> techniques;

  TeamTemtem({
    required this.temtem,
    required this.trait,
    this.luma = false,
    this.gender = 'male',
    this.techniques = const [],
  });

  factory TeamTemtem.fromJson(Map<String, dynamic> json) {
    return TeamTemtem(
      temtem: Temtem.fromJson(json['temtem']),
      trait: json['trait'],
      luma: json['luma'] as bool,
      gender: json['gender'] as String,
      techniques: (json['techniques'] as List<dynamic>)
          .map((e) => TeamTemtemTechnique.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'temtem': temtem.toJson(),
        'luma': luma,
        'trait': trait,
        'gender': gender,
        'techniques': techniques.map((e) => e.toJson()).toList(),
      };
}

class Team {
  int id = 0;
  String name;
  List<TeamTemtem> temtems;
  int sort;

  Team(
      {this.id = 0,
      this.sort = 0,
      required this.name,
      this.temtems = const []});

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      name: json['name'],
      temtems: (json['temtems'] as List<dynamic>)
          .map((e) => TeamTemtem.fromJson(e))
          .toList(),
      sort: json['sort'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id > 0 ? id : null,
        'name': name,
        'temtems': temtems.map((e) => e.toJson()).toList(),
        'sort': sort,
      };
}
