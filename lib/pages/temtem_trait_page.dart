import 'package:flutter/material.dart';
import 'package:tempedia/components/admob/admob_banner.dart';
import 'package:tempedia/components/divider_with_text.dart';
import 'package:tempedia/components/html_view.dart';
import 'package:tempedia/components/loading.dart';
import 'package:tempedia/components/temtem/temtem_small_list_with_traits.dart';
import 'package:tempedia/models/temtem.dart';
import 'package:tempedia/models/trait.dart';
import 'package:tempedia/api/temtem.dart' as api;

class TemtemTraitPage extends StatefulWidget {
  final String name;
  final TemtemTrait? data;

  const TemtemTraitPage({super.key, required this.name, required this.data});

  @override
  State<StatefulWidget> createState() => _TemtemTraitPageState();
}

class _TemtemTraitPageState extends State<TemtemTraitPage> {
  @override
  void initState() {
    super.initState();
    findTemtemsByTrait();
  }

  List<Temtem> temtems = [];

  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    final name = widget.name;
    return Scaffold(
      appBar: AppBar(
        title: Text('Trait - $name'),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        padding: const EdgeInsets.all(10),
        children: [
          const AdMobBanner(),
          Text(
            name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          Container(
            margin: const EdgeInsets.only(top: 0),
            child: HtmlView(data: '${data?.description}'),
          ),
          Container(
            padding: const EdgeInsets.only(left: 8, top: 10),
            child: Table(
              columnWidths: const {
                0: FixedColumnWidth(80),
                1: FlexColumnWidth(),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: <TableRow>[
                TableRow(
                  children: <TableCell>[
                    const TableCell(
                      child: Text('Impact:'),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Text('${data?.impact}'),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: <TableCell>[
                    const TableCell(
                      child: Text('Trigger:'),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Text('${data?.trigger}'),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: <TableCell>[
                    const TableCell(
                      child: Text('Effect:'),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Text('${data?.effect}'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const DividerWithText(text: 'Temtem'),
          loading
              ? const Loading()
              : TemtemSmallListWithTraits(
                  temtems: temtems,
                ),
        ],
      ),
    );
  }

  bool loading = false;
  findTemtemsByTrait() async {
    try {
      setState(() {
        loading = true;
      });
      temtems = await api.findTemtemsByTrait(widget.name);
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }
}
