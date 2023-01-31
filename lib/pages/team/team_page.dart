import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tempedia/components/admob/admob_banner.dart';
import 'package:tempedia/components/team/add_team_temtem.dart';
import 'package:tempedia/components/team/team_temtem_item.dart';
import 'package:tempedia/models/db.dart';
import 'package:tempedia/models/team.dart';
import 'package:tempedia/models/temtem.dart';

import 'package:tempedia/api/user.dart' as api;

class TeamPage extends StatefulWidget {
  final Team data;
  const TeamPage({super.key, required this.data});

  @override
  State<StatefulWidget> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  late String name;
  late List<TeamTemtem> temtems;
  @override
  void initState() {
    super.initState();

    name = widget.data.name;
    temtems = List.from(widget.data.temtems);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (int i = 0; i < temtems.length; i++) {
      children.add(
        TeamTemtemItem(
          data: temtems[i],
          key: ValueKey(temtems[i]),
          index: i,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              switch (value) {
                case 0:
                  _showRenameDialog(context);
                  break;
                case 1:
                  _saveTeam();
                  break;
                case 2:
                  _deleteTeam();
                  break;
                case 3:
                  _shareTeam();
                  break;
                case 4:
                  _showNoticeDialog();
                  break;
                default:
              }
            },
            itemBuilder: (context) => <PopupMenuEntry>[
              const PopupMenuItem<int>(
                value: 0,
                child: Text("Rename"),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text("Save"),
              ),
              PopupMenuItem<int>(
                value: 2,
                child: Text(
                  'Delete',
                  style: TextStyle(
                    color: Theme.of(context).errorColor,
                  ),
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem<int>(
                value: 3,
                child: Text("Share"),
              ),
              const PopupMenuItem<int>(
                value: 4,
                child: Text("Notice"),
              ),
            ],
          ),
        ],
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.transparent,
          // shadowColor: Colors.transparent,
        ),
        child: ReorderableListView(
          padding: const EdgeInsets.all(10),
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          onReorder: (int start, int current) {
            // dragging from top to bottom
            if (start < current) {
              int end = current - 1;
              final startItem = temtems[start];
              int i = 0;
              int local = start;
              do {
                temtems[local] = temtems[++local];
                i++;
              } while (i < end - start);
              temtems[end] = startItem;
            }
            // dragging from bottom to top
            else if (start > current) {
              final startItem = temtems[start];
              for (int i = start; i > current; i--) {
                temtems[i] = temtems[i - 1];
              }
              temtems[current] = startItem;
            }
            setState(() {});
          },
          header: const AdMobBanner(),
          footer: temtems.length < 6
              ? AddTeamTemtem(
                  add: addTemtem,
                )
              : null,
          children: children,
        ),
      ),
    );
  }

  addTemtem(Temtem data) {
    final item = TeamTemtem(
      temtem: data,
      trait: data.traits[0],
      gender: data.genderRatio.defaultGender(),
    );
    if (data.techniqueGroup != null &&
        data.techniqueGroup!.levelingUp.isNotEmpty) {
      item.techniques = [];
      for (int i = 0; i < min(4, data.techniqueGroup!.levelingUp.length); i++) {
        item.techniques.add(
          TeamTemtemTechnique(
            technique: data.techniqueGroup!.levelingUp[i].technique,
            egg: false,
            course: false,
          ),
        );
      }
    }
    temtems.add(item);
    setState(() {});
  }

  final _renameFieldController = TextEditingController();

  _showRenameDialog(BuildContext context) async {
    _renameFieldController.text = name;
    String? n = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Rename Your Team'),
          content: TextField(
            controller: _renameFieldController,
            decoration: const InputDecoration(hintText: "Such as 'Water Team'"),
            maxLength: 32,
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                if (_renameFieldController.text.isEmpty) {
                  return;
                }
                Navigator.pop(context, _renameFieldController.text);
              },
            ),
          ],
        );
      },
    );
    if (n != null) {
      name = n;
      setState(() {});
    }
  }

  Future<Team> _saveTeam() async {
    final t = Team(
      id: widget.data.id,
      name: name,
      temtems: temtems,
    );
    widget.data.id = await saveTeam(t);
    Fluttertoast.showToast(msg: 'Team Saved');
    return t;
  }

  _deleteTeam() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm?'),
        content: const Text('Are you sure to delete this team?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel')),
          TextButton(
              onPressed: () async {
                deleteTeam(widget.data.id);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Delete')),
        ],
      ),
    );
  }

  _showNoticeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Notice'),
        content: const Text(
            'Team data is locally stored, which mean it will be lost if you uninstall this app.\nTeam sharing is in development, you will be able to share your teams with friends soon. '),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          )
        ],
      ),
    );
  }

  _shareTeam() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Share Your Team'),
        content: const Text(
            'Once share link is generated, it cannot be modified. But you can share again, which will generate a new share link.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: _share,
            child: const Text(
              'Understood and Share',
            ),
          )
        ],
      ),
    );
  }

  var loading = false;
  _share() async {
    if (temtems.isEmpty) {
      Fluttertoast.showToast(msg: 'Empty team cannot be shared.');
      return;
    }
    Navigator.pop(context);
    final t = await _saveTeam();
    String url = '';
    try {
      showLoading();
      url = await api.shareUserTeam(t.name, t.temtems);
    } catch (e) {
      Fluttertoast.showToast(msg: 'Network Error');
    } finally {
      Navigator.of(context).pop();
    }
    if (url.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Copy Share Link'),
          content: Text(url),
          actions: [
            TextButton(
              onPressed: () => _copy(url),
              child: const Text(
                'Copy',
              ),
            )
          ],
        ),
      );
    }
  }

  _copy(String url) async {
    Navigator.pop(context);
    await Clipboard.setData(ClipboardData(text: url));
    Fluttertoast.showToast(msg: 'Share Link Copied');
  }

  showLoading() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return Dialog(
          // The background color
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                // The loading indicator
                CircularProgressIndicator(),
                SizedBox(
                  height: 15,
                ),
                // Some text
                Text('Loading...')
              ],
            ),
          ),
        );
      },
    );
  }
}
