import 'package:flutter/material.dart';
import 'package:tempedia/api/db.dart' as api;
import 'package:tempedia/components/html_view.dart';
import 'package:tempedia/components/loading.dart';
import 'package:tempedia/models/trait.dart';
import 'package:tempedia/pages/temtem_trait_page.dart';
import 'package:tempedia/utils/transition.dart';

class TemtemTraitCard extends StatefulWidget {
  final String name;
  final TemtemTrait? data;
  final Function()? onTap;

  const TemtemTraitCard({super.key, required this.name, this.data, this.onTap});

  @override
  State<StatefulWidget> createState() => _TemtemTraitCard();
}

class _TemtemTraitCard extends State<TemtemTraitCard> {
  TemtemTrait? data;

  @override
  void initState() {
    super.initState();
    if (widget.data == null) {
      getTemtemTrait();
    } else {
      data = widget.data;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap!();
            return;
          }
          Navigator.push(
            context,
            DefaultMaterialPageRoute(
              builder: (context) => TemtemTraitPage(
                name: widget.name,
                data: data,
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                widget.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 0),
                child: data != null
                    ? HtmlView(data: '${data?.description}')
                    : const Loading(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool loading = false;
  getTemtemTrait() async {
    try {
      setState(() {
        loading = true;
      });
      data = await api.getTemtemTraitWithDB(widget.name);
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }
}
