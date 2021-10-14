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
  final ValueChanged<AssetEntity>? onItemSelected;
  final bool value;

  const MediaItemWidget(
      {Key? key,
      required this.entity,
      required this.option,
      this.onItemSelected,
      required this.type,
      required this.value})
      : super(key: key);

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
          }
          if (snapshot.hasData) {
            ImageLruCache.setData(item, size, ThumbFormat.png, snapshot.data!);
            w = _buildImageWidget(item, snapshot.data!, size);
          } else {
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
    return Stack(
      children: [
        Image.memory(
          uint8list,
          width: size.toDouble(),
          height: size.toDouble(),
          fit: BoxFit.cover,
        ),
        if (widget.type == MediaSelectType.MULTIPLE)
          Align(
            alignment: Alignment.topRight,
            child: LhCheckBox(
              // value: checked.contains(entity),
              value: widget.value,
              onChanged: (value) {
                // if (checked.contains(entity)) {
                //   checked.remove(entity);
                // } else {
                //   checked.add(entity);
                // }
                // setState(() {});
              },
              builder: (bool isChecked) {
                return Container(
                  color: isChecked ? Colors.red.withOpacity(0.3) : Colors.green.withOpacity(0.3),
                );
              },
            ),
          ),
        Positioned.fill(
            child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () async {
              // origin file path
              // entity.originFile
              var file = await entity.originFile;
              print('entity ${(file!.path)}');
              if (widget.onItemSelected != null) {
                widget.onItemSelected!(entity);
              }
            },
            child: Container(),
          ),
        )),
      ],
    );
  }
}
