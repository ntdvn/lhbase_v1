import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhbase_v1/expansion_package/expansion_package.dart';
import 'package:lhbase_v1/lhbase.dart';
import 'package:photo_manager/photo_manager.dart';

enum MediaSelectType { SINGLE, MULTIPLE }

class MediaResourceView extends StatefulWidget {
  final MediaPickerController mediaController;
  final ValueChanged<List<MediaEntity>>? onSelectedChanged;
  final SliverGridDelegate? gridDelegate;
  final ScrollPhysics? physics;
  final bool shrinkWrap;

  const MediaResourceView(
      {Key? key,
      required this.mediaController,
      this.onSelectedChanged,
      this.gridDelegate,
      this.physics,
      this.shrinkWrap = false})
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
          child: GridView.builder(
            controller: _controller,
            physics: widget.physics ?? ScrollPhysics(),
            shrinkWrap: widget.shrinkWrap,
            padding:
                EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
            // itemCount: controller.showItemCount,
            itemCount: controller.mediaEntities.length,
            gridDelegate: widget.gridDelegate ??
                SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, mainAxisSpacing: 1, crossAxisSpacing: 1),
            itemBuilder: (context, index) {
              return _buildItem(controller.mediaEntities, index);
            },
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
  ThumbOption get thumbOption => ThumbOption(
        width: 128,
        height: 128,
        format: ThumbFormat.png,
        quality: 70,
      );

  Widget _buildItem(List<MediaEntity> listValue, int index) {
    final list = listValue;
    // if (list.length == index) {
    //   onLoadMore();
    //   return MediaLoading();
    // }

    if (index > list.length) {
      return Container();
    }
    return MediaContainer(
      key: ValueKey(index),
      onTap: () {
        widget.mediaController.addSelected(index);
        if (widget.onSelectedChanged != null)
          widget.onSelectedChanged!(widget.mediaController.selecteds);
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
