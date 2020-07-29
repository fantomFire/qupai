import 'package:flutter/material.dart';
import 'package:qupai/utils/uiutils.dart';
import 'package:cached_network_image/cached_network_image.dart';
class CacheImageView extends StatelessWidget {
  final String errorImage;
  final double width;
  final double height;
  final String netImageUrl;

  const CacheImageView(this.netImageUrl,
      {Key key, this.height, this.width, this.errorImage: "app"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: netImageUrl,
      width: width,
      height: height,
      /*     placeholder: (context, url) =>
          Image.asset(UiUtils.getImgPath(errorImage)),*/
      errorWidget: (context, url, error) =>
          Image.asset(UiUtils.getImgPath(errorImage)),
      fit: BoxFit.fill,
    );
  }
}
