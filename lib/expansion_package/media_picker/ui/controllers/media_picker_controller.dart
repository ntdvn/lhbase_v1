import 'package:get/get.dart';
import 'package:lhbase_v1/lhbase.dart';
import 'package:photo_manager/photo_manager.dart';

enum MediaPickerType {
  IMAGE,
  VIDEO,
  AUDIO,
  ALL,
  COMMON,
}

class MediaPickerController extends GetxController {
  final MediaPickerType mediaType;

  final int number;
  final int initLoadCount;
  final int loadCount;
  final bool cameraPicker;

  MediaPickerController(
      {this.mediaType = MediaPickerType.IMAGE,
      this.number = 1,
      this.initLoadCount = 47,
      this.loadCount = 23,
      this.cameraPicker = false}) {
    switch (this.mediaType) {
      case MediaPickerType.IMAGE:
        type = RequestType.image;
        break;
      case MediaPickerType.VIDEO:
        type = RequestType.video;
        break;
      case MediaPickerType.AUDIO:
        type = RequestType.audio;
        break;
      case MediaPickerType.ALL:
        type = RequestType.all;
        break;
      case MediaPickerType.COMMON:
        type = RequestType.common;
        break;
      default:
        type = RequestType.image;
        break;
    }
  }

  late RequestType type;

  Rx<List<MediaEntity>> _selecteds = Rx([]);

  List<MediaEntity> get selecteds => _selecteds.value;

  set selecteds(List<MediaEntity> value) {
    _selecteds.value = value;
  }

  Rx<AssetPathEntity?> _gallery = Rx(null);

  AssetPathEntity? get gallery => _gallery.value;

  set gallery(AssetPathEntity? value) {
    _gallery.value = value;
  }

  Rx<List<AssetPathEntity>> _galleries = Rx([]);

  List<AssetPathEntity> get galleries => _galleries.value;

  set galleries(List<AssetPathEntity> value) {
    _galleries.value = value;
  }

  Rx<List<MediaEntity>> _mediaEntities = Rx([]);

  List<MediaEntity> get mediaEntities => _mediaEntities.value;

  set mediaEntities(List<MediaEntity> value) {
    _mediaEntities.value = value;
  }

  //Config;

  var hasAll = true;

  // var onlyAll = true; //ios: true -> only all gallery, false -> all gallery
  var onlyAll = false;

  bool _containsEmptyAlbum = false;

  bool get containsEmptyAlbum => _containsEmptyAlbum;

  //Load more

  bool refreshing = false;
  var page = 0;

  int get showItemCount {
    if (gallery == null) return 0;
    if (mediaEntities.length == gallery!.assetCount) {
      return gallery!.assetCount;
    } else {
      return gallery!.assetCount;
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

    galleries.clear();
    galleries.addAll(galleryList);
    // update(galleries);
    // refresh();

    if (galleries.length > 0 && this.gallery == null) {
      this.gallery = galleries.first;
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
    if (gallery != null) {
      await gallery!.obtainForNewProperties(maxDateTimeToNow: true);
      // refreshPathProperties(
      //   maxDateTimeToNow: true,
      // );
      final list =
          await gallery!.getAssetListPaged(page: 0, size: initLoadCount);
      // .getAssetListPaged(0, initLoadCount);
      page = 0;
      this.mediaEntities.clear();
      list.asMap().forEach((index, value) {
        this.mediaEntities.add(MediaEntity(value));
      });
    }

    update();
  }

  Future<void> onLoadMore(String a) async {
    if (showItemCount > gallery!.assetCount) {
      print("already max");
      return;
    }
    final list =
        await gallery!.getAssetListPaged(page: page + 1, size: loadCount);

    page = page + 1;
    list.asMap().forEach((index, value) {
      this.mediaEntities.add(MediaEntity(value));
    });
    update();
  }

  void reset() {
    this.mediaEntities.clear();
    this.gallery = null;
    refresh();
  }

  addSelected(int index) {
    if (selecteds.contains(mediaEntities[index])) {
      selecteds.remove(mediaEntities[index]);
    } else {
      if (selecteds.length < number) selecteds.add(mediaEntities[index]);
    }
    mediaEntities[index].isSelected = !mediaEntities[index].isSelected;
    update();
  }

  changeGallery(int index) {
    gallery = galleries[index];
    onRefresh();
  }

  refreshSelected() {
    // _selecteds.value.clear();

    // print('selected $selecteds');
    // _selecteds.refresh();
    selecteds.clear();
    update();
  }

  @override
  void onReady() {
    refreshGalleries();
    super.onReady();
  }
}
