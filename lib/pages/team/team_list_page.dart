import 'package:flutter/material.dart';
import 'package:tempedia/components/team/team_item.dart';
import 'package:tempedia/models/db.dart';
import 'package:tempedia/models/team.dart';
import 'package:tempedia/pages/team/team_page.dart';
import 'package:tempedia/utils/transition.dart';

class TeamListPage extends StatefulWidget {
  const TeamListPage({super.key});

  @override
  State<StatefulWidget> createState() => _TeamListPageState();
}

class _TeamListPageState extends State<TeamListPage> {
  List<Team> teams = [];
  @override
  void initState() {
    super.initState();
    findTeams();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Teams'),
        actions: [
          IconButton(
            onPressed: () {
              newTeam(Team(name: 'Unnamed Team'));
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        padding: const EdgeInsets.all(10),
        children: teams
            .map(
              (e) => TeamItem(
                data: e,
                onTap: () => newTeam(e),
              ),
            )
            .toList(),
      ),
    );
  }

  findTeams() async {
    teams = await queryTeamsFromDB();
    setState(() {});
  }

  newTeam(Team data) async {
    await Navigator.push(
      context,
      DefaultMaterialPageRoute(
        builder: (context) => TeamPage(
          data: data,
        ),
      ),
    );
    findTeams();
  }
}
