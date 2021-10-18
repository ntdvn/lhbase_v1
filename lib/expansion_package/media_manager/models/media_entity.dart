import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:photo_manager/photo_manager.dart';

class MediaEntity extends Equatable {
  final AssetEntity assetEntity;
  late File? originFile;
  bool isSelected;

  MediaEntity(this.assetEntity, {this.isSelected = false}) {
    // getOriginfile();
  }

  setSelected(bool selected) {
    this.isSelected = selected;
  }

  @override
  String toString() {
    return "MediaEntity assetEntity: $assetEntity, isSelected: $isSelected";
  }

  getOriginfile() async {
    originFile = await assetEntity.originFile;
  }

  @override
  List<Object?> get props => [assetEntity.id];
}
