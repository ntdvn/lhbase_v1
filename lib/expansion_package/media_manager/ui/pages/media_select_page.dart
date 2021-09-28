import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhbase_v1/expansion_package/expansion_package.dart';
import 'package:lhbase_v1/lhbase.dart';
import 'package:photo_manager/photo_manager.dart';

enum MediaSelectType { SINGLE, MULTIPLE }

class MediaSelectPage extends StatelessWidget {
  final MediaSelectType type;
  final int? number;
  MediaSelectPage({Key? key, required this.type, this.number})
      : assert(
          (type == MediaSelectType.MULTIPLE && number != null && number > 0) ||
              (type == MediaSelectType.SINGLE && number == null),
        ),
        super(key: key);
  final _mediaController = Get.find<MediaManagerController>();

  @override
  Widget build(BuildContext context) {
    // if (_mediaController.galleryAllPath == null) {
    _mediaController.refreshGalleryList();
    // }
    // Container()
    return LhBasePage(
      child: Container(
        child: RefreshIndicator(onRefresh: () async {
          // print('lenth ${_mediaController.listAssetEntity.value.length}');
          _mediaController.refreshGalleryList();
        }, child: GetX<MediaManagerController>(
          builder: (controller) {
            return GridView.builder(
              itemCount: controller.showItemCount,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (context, index) {
                // print('itemBuilder $index');
                return _buildItem(controller.listAssetEntity.value, index);
              },
            );
          },
        )),
      ),
    );
  }

  //image thumb quality
  ThumbOption get thumbOption => ThumbOption(
      width: 128, height: 128, format: ThumbFormat.png, quality: 80);

  Widget _buildItem(List<AssetEntity> listValue, int index) {
    final list = listValue;
    if (list.length == index) {
      onLoadMore();
      return MediaLoading();
    }

    if (index > list.length) {
      return Container();
    }
    return MediaItemWidget(
      entity: _mediaController.listAssetEntity.value[index],
      option: thumbOption,
      onItemSelected: (value) {
        if (_mediaController.selectedList.value.contains(value)) {
          _mediaController.selectedList.value.remove(value);
        } else {
          _mediaController.selectedList.value.add(value);
        }

        _mediaController.listAssetEntity.refresh();
      },
      type: type,
      value: _mediaController.selectedList.value
          .contains(_mediaController.listAssetEntity.value[index]),
    );
  }

  Future<void> onLoadMore() async {
    // if (!mounted) {
    //   return;
    // }
    await _mediaController.onLoadMore();
  }
}
