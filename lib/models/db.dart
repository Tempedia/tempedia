import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tempedia/models/team.dart';
import 'package:tempedia/models/temtem.dart';
import 'package:tempedia/models/trait.dart';
import 'dart:convert';

late Future<Database> sqlitedb;

const tableTemtemType = 'temtem_type';
const tableTemtemTrait = 'temtem_trait';
const tableTemtemTeam = "temtem_team";

createDatabases(Database db, int version) async {
  await db.execute(
    'CREATE TABLE $tableTemtemType(name VARCHAR(64) PRIMARY KEY, icon TEXT, comment TEXT,sort INT,updated_at INTEGER,effective_against TEXT,ineffective_against TEXT,resistant_to TEXT,weak_to TEXT,color TEXT)',
  );
  await db.execute(
    'CREATE TABLE $tableTemtemTrait(name VARCHAR(64) PRIMARY KEY, description TEXT, trigger TEXT,impact TEXT, effect TEXT,updated_at INTEGER)',
  );
  await db.execute(
    'CREATE TABLE $tableTemtemTeam(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, temtems TEXT, sort INT)',
  );
}

dropTables(Database db) async {
  await db.execute('DROP TABLE IF EXISTS $tableTemtemType');
  await db.execute('DROP TABLE IF EXISTS $tableTemtemTrait');
  await db.execute('DROP TABLE IF EXISTS $tableTemtemTeam');
}

updateDatabases(Database db, int oldVersion, int newVersion) async {
  await dropTables(db);
  await createDatabases(db, newVersion);
}

initialDatabase() async {
  sqlitedb = openDatabase(
    join(await getDatabasesPath(), 'tempedia.db'),
    version: 3,
    onCreate: createDatabases,
    onUpgrade: updateDatabases,
  );
}

Future<List<TemtemType>> queryTemtemTypesFromDB() async {
  final db = await sqlitedb;

  final List<Map<String, dynamic>> maps = await db.query(
    tableTemtemType,
    orderBy: 'sort',
  );

  return List.generate(maps.length, (i) {
    return TemtemType.fromJson(maps[i]);
  });
}

Future<void> deleteTemtemTypes() async {
  final db = await sqlitedb;
  await db.delete(tableTemtemType);
}

Future<TemtemTrait?> getTemtemTraitFromDB(String name) async {
  final db = await sqlitedb;
  final maps = await db.query(
    tableTemtemTrait,
    where: 'name = ?',
    whereArgs: [name],
  );
  if (maps.isEmpty) {
    return null;
  }

  return TemtemTrait.fromJson(maps[0]);
}

Future<TemtemType?> getTemtemTypeFromDB(String name) async {
  final db = await sqlitedb;
  final maps = await db.query(
    tableTemtemType,
    where: 'name = ?',
    whereArgs: [name],
  );
  if (maps.isEmpty) {
    return null;
  }

  return TemtemType.fromJson(maps[0]);
}

Future<List<Team>> queryTeamsFromDB() async {
  final db = await sqlitedb;

  final List<Map<String, dynamic>> maps = await db.query(
    tableTemtemTeam,
    orderBy: 'sort',
  );

  List<Team> teams = [];
  for (var m in maps) {
    teams.add(
      Team(
        id: m['id'],
        sort: m['sort'],
        name: m['name'],
        temtems: (json.decode(m['temtems']) as List<dynamic>)
            .map((e) => TeamTemtem.fromJson(e))
            .toList(),
      ),
    );
  }
  return teams;
}

Future<int> saveTeam(Team t) async {
  final db = await sqlitedb;

  return await db.insert(
    tableTemtemTeam,
    {
      'id': t.id > 0 ? t.id : null,
      'sort': t.sort,
      'name': t.name,
      'temtems': json.encode(t.temtems),
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<void> deleteTeam(num id) async {
  final db = await sqlitedb;

  await db.delete(tableTemtemTeam, where: 'id=?', whereArgs: [id]);
}
