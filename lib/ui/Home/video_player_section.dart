import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerSection extends StatefulWidget {
  const VideoPlayerSection({
    Key key,
  }) : super(key: key);

  @override
  _VideoPlayerSectionState createState() => _VideoPlayerSectionState();
}

class _VideoPlayerSectionState extends State<VideoPlayerSection> {
  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    this.initializePlayer();
    // _chewieController.pause();
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController1 = VideoPlayerController.network(
        'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4');
    await _videoPlayerController1.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: false,
      looping: true,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: _chewieController != null &&
                _chewieController.videoPlayerController.value.initialized
            ? Color(0XFFFFFFFF)
            : Color(0XFFD4D4D4),
      ),
      height: 204,
      width: MediaQuery.of(context).size.width - 32,
      child: _chewieController != null &&
              _chewieController.videoPlayerController.value.initialized
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Chewie(
                controller: _chewieController,
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
              ],
            ),
    );
  }
}
