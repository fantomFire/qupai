import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qupai/utils/uiutils.dart';
class ImageNetworkCircle extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final BoxFit fit;
  final String defaultImage;
  final Map<String, String> headers;
  final Uint8List bytes;

  const ImageNetworkCircle(
      {Key key,
      this.url,
      this.width: double.infinity,
      this.height: double.infinity,
      this.fit: BoxFit.cover,
      this.defaultImage: "assets/images/test.png",
      this.headers,
      this.bytes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (url == null || url.length == 0)
        ? (bytes == null || bytes.length == 0)
            ? ClipOval(
                child: Image.asset(
                  defaultImage,
                  width: width,
                  height: height,
                  fit: fit,
                ),
              )
            : ClipOval(
                child: Image.memory(
                  bytes,
                  width: width,
                  height: height,
                  fit: fit,
                ),
              )
        : ClipOval(
            child: CachedNetworkImage(
              width: width,
              height: height,
              imageUrl: url,
              fit: fit,
              httpHeaders: headers,
              placeholder: (context, url) => Image.asset(
                UiUtils.getImgPath('test'),
                width: width,
                height: height,
                fit: fit,
              ),
              errorWidget: (context, url, error) => Image.asset(
                UiUtils.getImgPath('test'),
                width: width,
                height: height,
                fit: fit,
              ),
            ),
          );
  }
}
