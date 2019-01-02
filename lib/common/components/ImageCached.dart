import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cat_dog/styles/colors.dart';

class ImageCached extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  ImageCached({ Key key, this.url, dynamic width, dynamic height }) :
    width = width == null ? double.infinity : width,
    height = height == null ? double.infinity : height,
    super(key: key);
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      placeholder: new Center(
        child: SpinKitCubeGrid(
          color: AppColors.specicalBackgroundColor,
          size: 32
        )
      ),
      errorWidget: new Icon(Icons.broken_image, color: AppColors.specicalBackgroundColor),
      fit: BoxFit.cover
    );
  }
}