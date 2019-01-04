import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cat_dog/styles/colors.dart';

class ImageCached extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final Widget placeholder;
  final String noimage;
  final BoxFit fit;
  ImageCached({
    Key key,
    this.url,
    dynamic fit,
    dynamic width,
    dynamic height,
    dynamic noimage,
    dynamic placeholder
  }) :
    noimage = noimage,
    fit = fit == null ? BoxFit.cover : fit,
    width = width == null ? double.infinity : width,
    height = height == null ? double.infinity : height,
    placeholder = placeholder != null
      ? placeholder
      : Center(
        child: SpinKitPulse(
          color: AppColors.specicalBackgroundColor,
          size: 32
        )
      ),
    super(key: key);
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      placeholder: placeholder,
      errorWidget: noimage == null
        ? Icon(Icons.broken_image, color: AppColors.specicalBackgroundColor)
        : Image.asset(
          noimage,
          fit: BoxFit.cover
        ),
      fit: fit
    );
  }
}