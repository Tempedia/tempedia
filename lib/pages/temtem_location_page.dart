import 'package:flutter/material.dart';
import 'package:tempedia/api/location.dart' as api;
import 'package:tempedia/components/admob/admob_banner.dart';
import 'package:tempedia/components/expandable_tabview.dart';
import 'package:tempedia/components/html_view.dart';
import 'package:tempedia/components/image_viewer.dart';
import 'package:tempedia/components/temtem/temtem_location_area_temtem_item.dart';
import 'package:tempedia/models/location.dart';

class TemtemLocationPage extends StatefulWidget {
  final TemtemLocation data;
  final String? tag;

  const TemtemLocationPage({super.key, required this.data, this.tag});

  @override
  State<StatefulWidget> createState() => _TemtemLocationPageState();
}

class _TemtemLocationPageState extends State<TemtemLocationPage> {
  List<TemtemLocationArea> areas = [];

  @override
  void initState() {
    super.initState();

    findTemtemLocationAreas();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;

    List<String> tabs = [];
    List<Widget> children = [];
    for (var a in areas) {
      tabs.add(a.name);
      children.add(Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: ImageViewer(
                fileid: a.image,
                tag: '${data.name}-${a.name}',
              ),
            ),
            SizedBox(
              height: 250,
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 10),
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: a.temtems.length,
                itemBuilder: (_, i) =>
                    TemtemLocationAreaTemtemItem(data: a.temtems[i]),
              ),
            ),
          ],
        ),
      ));
    }

    return Scaffold(
      appBar: AppBar(title: Text(data.name)),
      body: ListView(
        padding: const EdgeInsets.all(10),
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: [
          const AdMobBanner(),
          ImageViewer(
            fileid: data.image,
            tag: widget.tag,
          ),
          Row(
            children: [
              widget.tag != null
                  ? Hero(
                      tag: widget.tag!,
                      child: Material(
                        color: Colors.transparent,
                        child: FittedBox(
                          child: Text(
                            data.name,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Text(
                      data.name,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(left: 10, top: 2),
            child: Text('Island: ${data.island}'),
          ),
          HtmlView(data: data.description),
          tabs.isNotEmpty
              ? ExpandableTabView(tabs: tabs, children: children)
              : Container(),
        ],
      ),
    );
  }

  findTemtemLocationAreas() async {
    try {
      areas = await api.findTemtemLocationAreasByLocation(widget.data.name);
    } catch (e) {
    } finally {
      setState(() {});
    }
  }
}
