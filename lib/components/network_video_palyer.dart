import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:tempedia/api/file.dart';
import 'package:tempedia/components/loading.dart';
import 'package:video_player/video_player.dart';

class NetworkVideoPlayer extends StatefulWidget {
  final String url;
  const NetworkVideoPlayer({super.key, required this.url});

  @override
  State<StatefulWidget> createState() => _NetworkVideoPlayerState();
}

class _NetworkVideoPlayerState extends State<NetworkVideoPlayer> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();

    if (widget.url.isEmpty) {
      return;
    }
    _videoController = VideoPlayerController.network(fileurl(widget.url))
      ..initialize().then((_) {
        if (mounted) {
          setState(() {});
        }
      });
    _chewieController = ChewieController(
      videoPlayerController: _videoController!,
      autoPlay: true,
      looping: false,
    );
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _chewieController?.dispose();
    _videoController = null;
    _chewieController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.url.isEmpty) {
      return Container();
    }
    return (_videoController?.value.isInitialized ?? false)
        ? AspectRatio(
            aspectRatio: _videoController!.value.aspectRatio,
            child: Chewie(
              controller: _chewieController!,
            ),
          )
        : Container(
            padding: const EdgeInsets.all(10),
            child: const Loading(),
          );
  }
}
