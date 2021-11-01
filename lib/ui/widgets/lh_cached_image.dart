import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LhCachedImageWidget extends StatelessWidget {
  final String imageUrl;
  const LhCachedImageWidget({Key? key, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        progressIndicatorBuilder: (context, url, progress) {
          // final t = DateTime.now().toIso8601String();
          // print(
          //     "$t Progress: ${progress.progress} Downloaded: ${progress.downloaded}");
          return Center(
            child: CircularProgressIndicator.adaptive(
              value: progress.progress,
            ),
          );
        },
      ),
    );
  }
}
