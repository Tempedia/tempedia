import 'package:flutter/material.dart';
import 'package:tempedia/models/temtem.dart';
import 'package:tempedia/pages/team/team_temtem_select_page.dart';
import 'package:tempedia/utils/transition.dart';

class AddTeamTemtem extends StatefulWidget {
  final void Function(Temtem) add;
  const AddTeamTemtem({super.key, required this.add});

  @override
  State<StatefulWidget> createState() => _AddTeamTemtemState();
}

class _AddTeamTemtemState extends State<AddTeamTemtem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () async {
          final r = await Navigator.push(
            context,
            DefaultMaterialPageRoute(
              builder: (context) => const TeamTemtemSelectPage(),
            ),
          );
          if (r == null) {
            return;
          }
          widget.add(r);
        },
        child: Container(
          padding:
              const EdgeInsets.only(top: 30, bottom: 30, left: 10, right: 10),
          child: Icon(
            Icons.add,
            size: 56,
            color: Theme.of(context).iconTheme.color?.withAlpha(160),
          ),
        ),
      ),
    );
  }
}
