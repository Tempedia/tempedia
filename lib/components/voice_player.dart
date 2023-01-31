import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:tempedia/api/file.dart';

class VoicePlayer extends StatefulWidget {
  final String fileid;
  final double size;
  const VoicePlayer({super.key, required this.fileid, this.size = 22});

  @override
  State<StatefulWidget> createState() => _VoicePlayer();
}

class _VoicePlayer extends State<VoicePlayer> {
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    player.onPlayerComplete.listen((e) {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: play,
      child: Icon(
        loading ? Icons.pause_circle_outline : Icons.play_circle_outline,
        size: widget.size,
      ),
    );
  }

  bool loading = false;
  play() async {
    if (widget.fileid.isEmpty || loading) {
      return;
    }

    try {
      setState(() {
        loading = true;
      });
      await player.play(UrlSource(fileurl(widget.fileid)));
    } finally {}
  }
}
