import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhbase_v1/expansion_package/expansion_package.dart';
import 'package:lhbase_v1/lhbase.dart';
import 'package:photo_manager/photo_manager.dart';

enum MediaSelectType { SINGLE, MULTIPLE }

typedef OnMediaSelectedChanged(
    MediaEntity selected, List<MediaEntity> entities);

class MediaResourceView extends StatefulWidget {
  final MediaPickerController mediaController;
  final OnMediaSelectedChanged? onSelectedChanged;
  final SliverGridDelegate? gridDelegate;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final VoidCallback? onCameraTap;

  const MediaResourceView(
      {Key? key,
      required this.mediaController,
      this.onSelectedChanged,
      this.gridDelegate,
      this.physics,
      this.shrinkWrap = false,
      this.onCameraTap})
      : super(key: key);

  @override
  _MediaResourceViewState createState() => _MediaResourceViewState();
}

class _MediaResourceViewState extends State<MediaResourceView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MediaPickerController>(
      builder: (controller) {
        return NotificationListener<ScrollNotification>(
          onNotification: _handleScrollNotification,
          child: GridView(
            controller: _controller,
            physics: widget.physics ?? ScrollPhysics(),
            shrinkWrap: widget.shrinkWrap,
            padding:
                EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
            children: [
              if (controller.cameraPicker)
                LhInkwell(
                  onTap: widget.onCameraTap,
                  borderRadius: BorderRadius.zero,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                  ),
                  child: Icon(
                    Icons.camera_alt_rounded,
                    color: Colors.white,
                  ),
                ),
              ...List.generate(controller.mediaEntities.length,
                  (index) => _buildItem(controller.mediaEntities, index))
            ],
            // itemCount: controller.showItemCount,
            // itemCount: controller.mediaEntities.length,
            gridDelegate: widget.gridDelegate ??
                SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, mainAxisSpacing: 1, crossAxisSpacing: 1),
            // itemBuilder: (context, index) {
            //   return _buildItem(controller.mediaEntities, index);
            // },
          ),
        );
      },
    );
  }

  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new ScrollController();
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      if (_controller.position.extentAfter == 0) {
        print("hihi");
        onLoadMore();
      }
    }
    return false;
  }

  //image thumb quality
  ThumbnailOption get thumbOption => ThumbnailOption(
       size:ThumbnailSize(128, 128) ,
        format: ThumbnailFormat.png,
        quality: 70,
      );

  Widget _buildItem(List<MediaEntity> listValue, int index) {
    final list = listValue;
    if (index > list.length) {
      return Container();
    }
    return MediaContainer(
      key: ValueKey(index),
      onTap: () {
        widget.mediaController.addSelected(index);
        if (widget.onSelectedChanged != null)
          widget.onSelectedChanged!(widget.mediaController.mediaEntities[index],
              widget.mediaController.selecteds);
      },
      child: MediaItemWidget(
        entity: widget.mediaController.mediaEntities[index].assetEntity,
        option: thumbOption,
      ),
      isSelected: widget.mediaController.selecteds
          .contains(widget.mediaController.mediaEntities[index]),
      selectedText:
          "${widget.mediaController.selecteds.indexOf(widget.mediaController.mediaEntities[index]) + 1}",
    );
  }

  Future<void> onLoadMore() async {
    if (!mounted) {
      return;
    }
    await widget.mediaController.onLoadMore("a");
  }
}
