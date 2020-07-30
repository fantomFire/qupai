import 'dart:ui';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

//视频的item页面
class WZVideo extends StatefulWidget {
  String url;
  final bool looping;

  WZVideo({
    this.url,
    this.looping,
    Key key,
  }) : super(key: key);

  @override
  _WZVideoState createState() => _WZVideoState();
}

class _WZVideoState extends State<WZVideo> {
  ChewieController _chewieController;
  VideoPlayerController _videoPlayerController;
  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.url);
    //创建Chewie 的控制器
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9,
      autoInitialize: true,
      looping: widget.looping,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );

    print('控制器设置');
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(
      controller: _chewieController,
    );
  }

  @override
  void dispose() {
    //为了满足全屏时候 控制器不被直接销毁 判断只有不是全屏的时候 才允许控制器被销毁
    if (_chewieController != null && !_chewieController.isFullScreen) {
      _videoPlayerController.dispose();
      _chewieController.dispose();
      print('控制器销毁');
    }
    super.dispose();
  }
}
