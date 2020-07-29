import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

class ImageAnimation extends StatefulWidget {
  final double w;
  final double h;
  final ImagesAnimationEntry entry;
  final int durationSeconds;

  ImageAnimation(
      {Key key, this.w: 80, this.h: 80, this.entry, this.durationSeconds: 500})
      : super(key: key);

  @override
  _ImageAnimationState createState() => _ImageAnimationState();
}

class _ImageAnimationState extends State<ImageAnimation>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.durationSeconds))
      ..repeat();
    _animation =
        new IntTween(begin: widget.entry.lowIndex, end: widget.entry.highIndex)
            .animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animation,
        builder: (BuildContext context, Widget child) {
          String frame = _animation.value.toString();
          return new Image.asset(
            sprintf(widget.entry.basePath, [frame]), //根据传进来的参数拼接路径
            gaplessPlayback: true, //避免图片闪烁
            width: widget.w,
            height: widget.h,
            fit: BoxFit.contain,
          );
        });
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class ImagesAnimationEntry {
  int lowIndex = 0;
  int highIndex = 0;
  String basePath;

  ImagesAnimationEntry(this.lowIndex, this.highIndex, this.basePath);
}
