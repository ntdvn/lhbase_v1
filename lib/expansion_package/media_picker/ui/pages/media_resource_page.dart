import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhbase_v1/expansion_package/expansion_package.dart';
import 'package:lhbase_v1/lhbase.dart';
import 'package:photo_manager/photo_manager.dart';

enum MediaSelectType { SINGLE, MULTIPLE }

class MediaResoucePage extends StatefulWidget {
  final MediaPickerController mediaController;
  final ValueChanged<List<MediaEntity>>? onSelectedChanged;

  const MediaResoucePage(
      {Key? key, required this.mediaController, this.onSelectedChanged})
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
        }, child: GetBuilder<MediaPickerController>(
          builder: (controller) {
            // return GridView(
            //   padding: EdgeInsets.zero,
            //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 4, mainAxisSpacing: 1, crossAxisSpacing: 1),
            //   children: [
            //     GestureDetector(
            //         onTap: () {},
            //         child: Container(
            //           color: Colors.grey.withOpacity(0.4),
            //           child: Icon(Icons.camera_alt),
            //         )),
            //     ...List.generate(controller.showItemCount, (index) {
            //       return _buildItem(controller.mediaEntities, index);
            //     })
            //   ],
            // );
            return GridView.builder(
              // cacheExtent: controller.showItemCount.toDouble(),
              // restorationId: 'abc',
              // addAutomaticKeepAlives: true,
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
              itemCount: controller.showItemCount,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, mainAxisSpacing: 1, crossAxisSpacing: 1),
              itemBuilder: (context, index) {
                return _buildItem(controller.mediaEntities, index);

                // return FutureBuilder<File?>(
                //   future: controller
                //       .mediaEntities.value[index].assetEntity.originFile,
                //   builder: (context, snapshot) {
                //     if(snapshot.hasData) {
                //       return Image.file(snapshot.data!);
                //     } else

                //     return Container(
                //       width: 100,
                //       height: 100,
                //       color: Colors.red,
                //     );
                //   },
                // );
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
        quality: 70,
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
