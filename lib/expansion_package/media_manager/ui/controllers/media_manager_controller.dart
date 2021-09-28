import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

class MediaManagerController extends GetxController {
  Rx<List<AssetEntity>> selectedList = Rx([]);

  Rx<AssetPathEntity?> galleryAllPath = Rx(null);
  // AssetPathEntity? _galleryAllPath;
  // get galleryAllPath => _galleryAllPath;

  Rx<List<AssetEntity>> listAssetEntity = Rx([]);
  // List<AssetEntity> get listAssetEntity => _listAssetEntity.value;

  RequestType type = RequestType.image;

  var hasAll = true;

  var onlyAll = true; //ios: true -> only all gallery, false -> all gallery

  bool _containsEmptyAlbum = false;

  bool get containsEmptyAlbum => _containsEmptyAlbum;

  //Load more

  bool refreshing = false;
  var page = 0;
  static const loadCount = 10;

  int get showItemCount {
    if (galleryAllPath.value == null) return 0;
    if (listAssetEntity.value.length == galleryAllPath.value!.assetCount) {
      return galleryAllPath.value!.assetCount;
    } else {
      return galleryAllPath.value!.assetCount;
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

  Future<void> refreshGalleryList() async {
    reset();
    List<AssetPathEntity> list = [];

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

    list.clear();
    list.addAll(galleryList);
    if (list.length > 0) {
      try {
        this.galleryAllPath.value = list.first;
        print(this.galleryAllPath.value);
      } catch (e) {
        print('dkm $e');
      }
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
    await galleryAllPath.value!.refreshPathProperties(
      maxDateTimeToNow: true,
    );
    final list = await galleryAllPath.value!.getAssetListPaged(0, loadCount);
    page = 0;
    this.listAssetEntity.value.clear();
    this.listAssetEntity.value.addAll(list);
    this.listAssetEntity.refresh();
  }

  Future<void> onLoadMore() async {
    if (showItemCount > galleryAllPath.value!.assetCount) {
      print("already max");
      return;
    }
    final list =
        await galleryAllPath.value!.getAssetListPaged(page + 1, loadCount);
    page = page + 1;
    this.listAssetEntity.value.addAll(list);
    this.listAssetEntity.refresh();
  }

  void reset() {
    this.listAssetEntity.value.clear();
    this.galleryAllPath.value = null;
    this.listAssetEntity.refresh();
  }
}
