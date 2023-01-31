import 'package:flutter/material.dart';
import 'package:tempedia/api/location.dart' as api;
import 'package:tempedia/components/admob/admob_banner.dart';
import 'package:tempedia/components/loading.dart';
import 'package:tempedia/components/temtem/temtem_location_list_item.dart';
import 'package:tempedia/models/location.dart';
import 'package:tempedia/models/temtem.dart';

class TemtemPageLocationFragment extends StatefulWidget {
  final Temtem data;
  const TemtemPageLocationFragment({super.key, required this.data});

  @override
  State<StatefulWidget> createState() => _TemtemPageLocationFragmentState();
}

class _TemtemPageLocationFragmentState extends State<TemtemPageLocationFragment>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    findTemtemLocations();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    int i = 0;
    List<Widget> children = [
      const AdMobBanner(),
    ];
    if (loading) {
      children.add(const Loading());
    } else if (locations.isNotEmpty) {
      children.addAll(
        locations
            .map((e) => TemtemLocationListItem(
                  data: e,
                  index: i++,
                ))
            .toList(),
      );
    } else {
      children.add(const Text(
        '404 Not Found',
        textAlign: TextAlign.center,
      ));
    }
    return ListView(
      padding: const EdgeInsets.all(10),
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      children: children,
    );
  }

  List<TemtemLocation> locations = [];
  bool loading = false;
  findTemtemLocations() async {
    try {
      setState(() {
        loading = true;
      });
      locations = await api.findTemtemLocationsByTemtem(widget.data.name);
    } finally {
      setState(() {
        loading = false;
      });
    }
  }
}
