import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhbase_v1/expansion_package/expansion_package.dart';
import 'package:lhbase_v1/lhbase.dart';
import 'package:photo_manager/photo_manager.dart';

enum MediaSelectType { SINGLE, MULTIPLE }

class MediaResoucePage extends StatefulWidget {
  final MediaManagerController mediaController;
  final MediaSelectType type;
  final int? number;
  final ValueChanged<List<MediaEntity>>? onSelectedChanged;

  const MediaResoucePage(
      {Key? key,
      required this.mediaController,
      required this.type,
      this.number,
      this.onSelectedChanged})
      : super(key: key);

  @override
  _MediaResoucePageState createState() => _MediaResoucePageState();
}

class _MediaResoucePageState extends State<MediaResoucePage> {
  @override
  Widget build(BuildContext context) {
    // // if (_mediaController.galleryAllPath == null) {
    // _mediaController.refreshGalleryList();
    // // }
    // // Container()
    return LhBasePage(
      child: Container(
        child: RefreshIndicator(onRefresh: () async {
          // print('lenth ${_mediaController.listAssetEntity.value.length}');
          widget.mediaController.onRefresh();
        }, child: GetX<MediaManagerController>(
          builder: (controller) {
            return GridView.builder(
              // cacheExtent: controller.showItemCount.toDouble(),
              // restorationId: 'abc',
              // addAutomaticKeepAlives: true,
              padding: EdgeInsets.zero,
              itemCount: controller.showItemCount,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, mainAxisSpacing: 1, crossAxisSpacing: 1),
              itemBuilder: (context, index) {
                return _buildItem(controller.mediaEntities.value, index);
              },
            );
          },
        )),
      ),
    );
  }

  //image thumb quality
  ThumbOption get thumbOption => ThumbOption(
        width: 128,
        height: 128,
        format: ThumbFormat.png,
        quality: 100,
      );

  Widget _buildItem(List<MediaEntity> listValue, int index) {
    final list = listValue;
    if (list.length == index) {
      onLoadMore();
      return MediaLoading();
    }

    if (index > list.length) {
      return Container();
    }
    return MediaContainer(
      key: ValueKey(index),
      onTap: () {
        widget.mediaController.addSelected(index);
        if(widget.onSelectedChanged!=null) widget.onSelectedChanged!(widget.mediaController.selecteds.value);
      },
      child: MediaItemWidget(
        entity: widget.mediaController.mediaEntities.value[index].assetEntity,
        option: thumbOption,
        type: widget.type,
      ),
      type: widget.type,
      isSelected: widget.mediaController.selecteds.value
          .contains(widget.mediaController.mediaEntities.value[index]),
      selectedText:
          "${widget.mediaController.selecteds.value.indexOf(widget.mediaController.mediaEntities.value[index]) + 1}",
    );
  }

  Future<void> onLoadMore() async {
    // if (!mounted) {
    //   return;
    // }
    await widget.mediaController.onLoadMore("a");
    // try {
    //    await _mediaController.isolateLoadmore();
    // } catch (e) {
    //   print('LOI $e');
    // }
  }
}
