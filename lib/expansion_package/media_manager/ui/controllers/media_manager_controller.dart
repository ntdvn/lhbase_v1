import 'package:flutter/foundation.dart';

import 'package:get/get.dart';
import 'package:lhbase_v1/expansion_package/media_manager/media_manager.dart';
import 'package:photo_manager/photo_manager.dart';

class MediaManagerController extends GetxController {
  Rx<List<MediaEntity>> selecteds = Rx([]);

  Rx<AssetPathEntity?> gallery = Rx(null);
  Rx<List<AssetPathEntity>> galleries = Rx([]);
  // AssetPathEntity? _galleryAllPath;
  // get galleryAllPath => _galleryAllPath;

  Rx<List<MediaEntity>> mediaEntities = Rx([]);
  // List<AssetEntity> get listAssetEntity => _listAssetEntity.value;

  RequestType type = RequestType.image;

  var hasAll = true;

  // var onlyAll = true; //ios: true -> only all gallery, false -> all gallery
  var onlyAll = false;

  bool _containsEmptyAlbum = false;

  bool get containsEmptyAlbum => _containsEmptyAlbum;

  //Load more

  bool refreshing = false;
  var page = 0;
  static const loadCount = 1000;

  int get showItemCount {
    if (gallery.value == null) return 0;
    if (mediaEntities.value.length == gallery.value!.assetCount) {
      return gallery.value!.assetCount;
    } else {
      return gallery.value!.assetCount;
    }
  }

  String minWidth = "0";
  String maxWidth = "10000";
  String minHeight = "0";
  String maxHeight = "10000";
  bool _ignoreSize = true;
  bool get ignoreSize => _ignoreSize;

  Duration _minDuration = Duration.zero;

  Duration get minDuration => _minDuration;

  Duration _maxDuration = Duration(hours: 1);

  Duration get maxDuration => _maxDuration;

  bool _containsPathModified = false;

  bool get containsPathModified => _containsPathModified;

  bool _asc = false;

  bool get asc => _asc;

  bool _needTitle = false;

  bool get needTitle => _needTitle;

  DateTime _startDt = DateTime(2005); // Default Before 8 years

  DateTime get startDt => _startDt;

  DateTime _endDt = DateTime.now();

  DateTime get endDt => _endDt;

  Future<void> refreshGalleries() async {
    reset();

    final option = makeOption();

    var galleryList = await PhotoManager.getAssetPathList(
      type: type,
      hasAll: hasAll,
      onlyAll: onlyAll,
      filterOption: option,
    );

    galleryList.sort((s1, s2) {
      return s2.assetCount.compareTo(s1.assetCount);
    });

    galleries.value.clear();
    galleries.value.addAll(galleryList);
    galleries.refresh();

    if (galleries.value.length > 0 && this.gallery.value == null) {
      this.gallery.value = galleries.value.first;
    }
    await onRefresh();
  }

  FilterOptionGroup makeOption() {
    final option = FilterOption(
      sizeConstraint: SizeConstraint(
        minWidth: int.tryParse(minWidth) ?? 0,
        maxWidth: int.tryParse(maxWidth) ?? 100000,
        minHeight: int.tryParse(minHeight) ?? 0,
        maxHeight: int.tryParse(maxHeight) ?? 100000,
        ignoreSize: ignoreSize,
      ),
      durationConstraint: DurationConstraint(
        min: minDuration,
        max: maxDuration,
      ),
      needTitle: needTitle,
    );

    final createDtCond = DateTimeCond(
      // min: startDt,
      // max: endDt,
      min: DateTime(1000),
      max: DateTime(3000),
      ignore: false,
    );

    return FilterOptionGroup()
      ..setOption(AssetType.video, option)
      ..setOption(AssetType.image, option)
      ..setOption(AssetType.audio, option)
      ..createTimeCond = createDtCond
      ..containsEmptyAlbum = _containsEmptyAlbum
      ..containsPathModified = _containsPathModified
      ..addOrderOption(
        OrderOption(
          type: OrderOptionType.updateDate,
          asc: asc,
        ),
      );
  }

  Future onRefresh() async {
    await gallery.value!.refreshPathProperties(
      maxDateTimeToNow: true,
    );
    final list = await gallery.value!.getAssetListPaged(0, loadCount);
    page = 0;
    this.mediaEntities.value.clear();
    list.asMap().forEach((index, value) {
      this.mediaEntities.value.add(MediaEntity(value));
    });
    // update(this.mediaEntities.value);
    this.mediaEntities.refresh();
  }

  Future<void> onLoadMore(String a) async {
    if (showItemCount > gallery.value!.assetCount) {
      print("already max");
      return;
    }
    final list = await gallery.value!.getAssetListPaged(page + 1, loadCount);

    page = page + 1;
    list.asMap().forEach((index, value) {
      this.mediaEntities.value.add(MediaEntity(value));
    });
    // update(this.mediaEntities.value);
    this.mediaEntities.refresh();
  }

  void reset() {
    this.mediaEntities.value.clear();
    this.gallery.value = null;
    this.mediaEntities.refresh();
  }

  addSelected(int index) {
    if (selecteds.value.contains(mediaEntities.value[index])) {
      selecteds.value.remove(mediaEntities.value[index]);
    } else {
      selecteds.value.add(mediaEntities.value[index]);
    }
    mediaEntities.value[index].isSelected =
        !mediaEntities.value[index].isSelected;

    print('mediaEntities ${mediaEntities.value[index]}');

    // this.selecteds.value.add(entity);
    // this.selecteds.refresh();
    this.mediaEntities.refresh();
    // D95E2D21-5B16-42D9-A9CE-35174928AC5F/L0/001
    
  }

  changeGallery(int index) {
    gallery.value = galleries.value[index];
    onRefresh();
  }

  @override
  void onReady() {
    refreshGalleries();
    super.onReady();
  }
}
