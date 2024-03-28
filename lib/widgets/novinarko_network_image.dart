import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NovinarkoNetworkImage extends StatelessWidget {
  final String imageUrl;
  final Widget? placeholderWidget;
  final Widget? errorWidget;
  final double? height;
  final double? width;
  final BoxFit? boxFit;

  const NovinarkoNetworkImage({
    required this.imageUrl,
    this.boxFit,
    this.placeholderWidget,
    this.errorWidget,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) => CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: placeholderWidget != null ? (_, __) => placeholderWidget! : null,
        errorWidget: errorWidget != null ? (_, __, ___) => errorWidget! : null,
        height: height,
        width: width,
        fit: boxFit ?? BoxFit.cover,
      );
}
