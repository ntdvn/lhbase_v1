import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lhbase_v1/expansion_package/expansion_package.dart';
import 'package:lhbase_v1/ui/ui.dart';
import 'package:photo_manager/photo_manager.dart';

class MediaItemWidget extends StatefulWidget {
  final MediaSelectType type;
  final AssetEntity entity;
  final ThumbOption option;

  const MediaItemWidget({
    Key? key,
    required this.entity,
    required this.option,
    required this.type,
  }) : super(key: key);

  @override
  _MediaItemWidgetState createState() => _MediaItemWidgetState();
}

class _MediaItemWidgetState extends State<MediaItemWidget> {
  @override
  Widget build(BuildContext context) {
    // if (widget.entity.type == AssetType.audio) {
    //   return Center(
    //     child: Icon(
    //       Icons.audiotrack,
    //       size: 30,
    //     ),
    //   );
    // }
    final item = widget.entity;
    final size = widget.option.width;
    final u8List = ImageLruCache.getData(item, size, ThumbFormat.png);
    Widget image;

    if (u8List != null) {
      // print('u8List');
      return _buildImageWidget(item, u8List, size);
    } else {
      // print('FutureBuilder');
      image = FutureBuilder<Uint8List?>(
        future: item.thumbDataWithOption(widget.option),
        builder: (context, snapshot) {
          Widget w;
          if (snapshot.hasError) {
            w = Center(
              child: Text("load error, error: ${snapshot.error}"),
            );
          }else 
          if (snapshot.hasData) {
            
            ImageLruCache.setData(item, size, ThumbFormat.png, snapshot.data!);
            w = _buildImageWidget(item, snapshot.data!, size);
          } 
          else {
            w = Center(
              child: MediaLoading(),
            );
          }

          return w;
        },
      );
    }

    return image;
  }

  Widget _buildImageWidget(AssetEntity entity, Uint8List uint8list, num size) {
    // return FadeInImage.memory(
    //   uint8list,
    //   width: size.toDouble(),
    //   height: size.toDouble(),
    //   fit: BoxFit.cover,
    // );
    return FadeInImage(fadeInDuration: Duration(milliseconds: 200), fit: BoxFit.cover, placeholder: AssetImage('assets/gifs/loading.gif',  package: 'lhbase_v1', ), image: MemoryImage(uint8list));
  }
}
