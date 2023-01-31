import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tempedia/themes/theme_manager.dart';

class ThemeSelectPage extends StatefulWidget {
  const ThemeSelectPage({super.key});

  @override
  State<StatefulWidget> createState() => _ThemeSelectPageState();
}

class _ThemeSelectPageState extends State<ThemeSelectPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeManager>(
      builder: (context, themeManager, child) => Scaffold(
        appBar: AppBar(title: const Text('Select Theme')),
        body: ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          padding: EdgeInsets.zero,
          children: ThemeManager.themeList
              .map((e) => _ThemeItem(
                    color: e.primaryColor,
                    selected:
                        themeManager.currentTheme.primaryColor.toString() ==
                            e.primaryColor.toString(),
                    onTap: () {
                      themeManager.setTheme(e);
                      setState(() {});
                    },
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class _ThemeItem extends StatelessWidget {
  final bool selected;
  final Color color;
  final Function() onTap;

  const _ThemeItem(
      {this.selected = false, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: color,
          border: selected ? Border.all(color: Colors.white, width: 5) : null,
        ),
      ),
    );
  }
}
