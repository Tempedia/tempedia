import 'package:flutter/material.dart';
import 'package:tempedia/components/temtem/temtem_trait_card.dart';
import 'package:tempedia/models/temtem.dart';

class TeamTemtemTraitSelectPage extends StatefulWidget {
  final Temtem data;
  const TeamTemtemTraitSelectPage({super.key, required this.data});

  @override
  State<StatefulWidget> createState() => _TeamTemtemTraitSelectPageState();
}

class _TeamTemtemTraitSelectPageState extends State<TeamTemtemTraitSelectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Trait')),
      body: ListView(
        padding: const EdgeInsets.all(10),
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        children: [
          TemtemTraitCard(
            name: widget.data.traits[0],
            onTap: () => select(widget.data.traits[0]),
          ),
          TemtemTraitCard(
            name: widget.data.traits[1],
            onTap: () => select(widget.data.traits[1]),
          ),
        ],
      ),
    );
  }

  select(String trait) {
    Navigator.pop(context, trait);
  }
}
