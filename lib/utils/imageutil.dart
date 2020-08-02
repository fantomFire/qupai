import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qupai/utils/uiutils.dart';

class ImageLoadUtil extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final BoxFit fit;
  final String defaultImage;
  final Map<String, String> headers;

  const ImageLoadUtil(
      {Key key,
      this.url,
      this.width: double.infinity,
      this.height: double.infinity,
      this.fit: BoxFit.cover,
      this.defaultImage: 'assets/images/app.png',
      this.headers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (url == null || url.length == 0)
        ? Image.asset(
            defaultImage,
            width: width,
            height: height,
            fit: fit,
          )
        : CachedNetworkImage(
            width: width,
            height: height,
            imageUrl: url,
            fit: fit,
            httpHeaders: headers,
          /*  placeholder: (context, url) => Image.asset(
              UiUtils.getImgPath('logo'),
              width: width,
              height: height,
              fit: fit,
            ),*/
            errorWidget: (context, url, error) => Image.asset(
              UiUtils.getImgPath('app'),
              width: width,
              height: height,
              fit: fit,
            ),
          );
  }
}
