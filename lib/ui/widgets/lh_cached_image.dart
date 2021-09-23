import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LhCachedImageWidget extends StatelessWidget {
  final String imageUrl;
  const LhCachedImageWidget({Key? key, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
    );
  }
}
