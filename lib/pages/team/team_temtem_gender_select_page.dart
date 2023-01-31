import 'package:flutter/material.dart';
import 'package:tempedia/components/gender_icon.dart';

class TeamTemtemGenderSelectPage extends StatefulWidget {
  const TeamTemtemGenderSelectPage({super.key});

  @override
  State<StatefulWidget> createState() => _TeamTemtemGenderSelectPageState();
}

class _TeamTemtemGenderSelectPageState
    extends State<TeamTemtemGenderSelectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Gender'),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        children: [
          GestureDetector(
            onTap: () => select('male'),
            child: const GenderIcon(
              gender: 'male',
              size: 240,
            ),
          ),
          GestureDetector(
            onTap: () => select('female'),
            child: const GenderIcon(
              gender: 'female',
              size: 240,
            ),
          ),
        ],
      ),
    );
  }

  select(String gender) {
    Navigator.pop(context, gender);
  }
}
