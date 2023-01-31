import 'package:tempedia/models/temtem.dart';

class TemtemLocation {
  final String name;
  final String description;
  final String island;
  final String image;
  final String comment;
  final List<String> connectedLocations;

  const TemtemLocation({
    required this.name,
    required this.description,
    required this.island,
    required this.comment,
    required this.image,
    required this.connectedLocations,
  });

  factory TemtemLocation.fromJson(Map<String, dynamic> json) {
    return TemtemLocation(
      name: json['name'],
      description: json['description'],
      island: json['island'],
      comment: json['comment'],
      image: json['image'],
      connectedLocations: parseListString(json['connected_locations']),
    );
  }
}

class TemtemLocationAreaOdds {
  final String odds;
  final String desc;
  TemtemLocationAreaOdds({required this.odds, required this.desc});

  factory TemtemLocationAreaOdds.fromJson(Map<String, dynamic> json) {
    return TemtemLocationAreaOdds(
      desc: json['desc'],
      odds: json['odds'],
    );
  }
}

class TemtemLocationAreaLevel {
  final int from;
  final int to;
  final bool egg;
  TemtemLocationAreaLevel({
    required this.from,
    required this.to,
    required this.egg,
  });

  factory TemtemLocationAreaLevel.fromJson(Map<String, dynamic> json) {
    return TemtemLocationAreaLevel(
      from: json['from'],
      to: json['to'],
      egg: json['egg'],
    );
  }
}

class TemtemLocationAreaTemtem {
  final String name;
  final List<TemtemLocationAreaOdds> odds;
  final TemtemLocationAreaLevel level;

  TemtemLocationAreaTemtem(
      {required this.name, required this.odds, required this.level});

  factory TemtemLocationAreaTemtem.fromJson(Map<String, dynamic> json) {
    return TemtemLocationAreaTemtem(
      name: json['name'],
      odds: (json['odds'] as List)
          .map((e) => TemtemLocationAreaOdds.fromJson(e))
          .toList(),
      level: TemtemLocationAreaLevel.fromJson(json['level']),
    );
  }
}

/*
	ID            int64                      `bun:"id,notnull,pk" json:"-"`
	Name          string                     `bun:"name,notnull" json:"name"`
	Location      string                     `bun:"location,notnull" json:"location"`
	Image         string                     `bun:"image,notnull,nullzero" json:"image"`
	Temtems       []TemtemLocationAreaTemtem `bun:"temtems,notnull,nullzero,type:jsonb" json:"temtems"`*/

class TemtemLocationArea {
  final int id;
  final String name;
  final String location;
  final String image;
  final List<TemtemLocationAreaTemtem> temtems;

  TemtemLocationArea(
      {required this.id,
      required this.name,
      required this.location,
      required this.image,
      required this.temtems});

  factory TemtemLocationArea.fromJson(Map<String, dynamic> json) {
    return TemtemLocationArea(
      id: json['id'] ?? 0,
      name: json['name'],
      location: json['location'],
      image: json['image'],
      temtems: (json['temtems'] as List)
          .map((e) => TemtemLocationAreaTemtem.fromJson(e))
          .toList(),
    );
  }
}
