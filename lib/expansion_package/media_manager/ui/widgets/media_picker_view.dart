import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhbase_v1/lhbase.dart';

class MediaPickerView extends StatefulWidget {
  final LhExpanableController controller;
  final ValueChanged<List<MediaEntity>>? onSelectedChanged;
  const MediaPickerView({Key? key, required this.controller, this.onSelectedChanged}) : super(key: key);

  @override
  _MediaPickerViewState createState() => _MediaPickerViewState();
}

class _MediaPickerViewState extends State<MediaPickerView> {
  late MediaManagerController _mediaController;
  LhDropdownViewController _lhDropdownViewController =
      LhDropdownViewController();
  @override
  void initState() {
    super.initState();
    Get.lazyPut(() => MediaManagerController(), fenix: true);
    _mediaController = Get.find<MediaManagerController>();
  }

  @override
  void dispose() {
    // _mediaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LhExpanableView(
        controller: widget.controller,
        child: LhBottomSheetUi(
          child: MediaResoucePage(
            mediaController: _mediaController,
            type: MediaSelectType.MULTIPLE,
            number: 2,
            onSelectedChanged: widget.onSelectedChanged,
          ),
          left: [
            Container(
                margin: EdgeInsets.only(left: 20),
                child: GetX<MediaManagerController>(
                  builder: (controller) {
                    return LhDropdownView(
                      controller: _lhDropdownViewController,
                      color: Colors.white,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 3.0, horizontal: 10),
                        decoration: BoxDecoration(
                            color: Color(0xFF3C3C3C),
                            borderRadius: BorderRadius.circular(500)),
                        child: Row(
                          children: [
                            Text(
                              '${controller.gallery.value != null ? controller.gallery.value!.name : ''} (${controller.showItemCount})',
                              style: LhStyle.DEFAULT_14
                                  .copyWith(color: Colors.white),
                            ),
                            Container(
                                margin: EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                    color: Color(0xFF9E9E9E),
                                    borderRadius: BorderRadius.circular(500)),
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 16,
                                ))
                          ],
                        ),
                      ),
                      dropdownPanel: IntrinsicWidth(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: List.generate(
                              controller.galleries.value.length, (index) {
                            return LhInkwell(
                                onTap: () {
                                  _mediaController.changeGallery(index);
                                  _lhDropdownViewController.togglePanel();
                                },
                                child: Text(
                                    '${controller.galleries.value[index].name} (${controller.galleries.value[index].assetCount})',
                                    style: LhStyle.DEFAULT_14.copyWith(
                                        color: Colors.black,
                                        fontStyle: FontStyle.normal)));
                          }),
                        ),
                      ),
                    );
                  },
                ))
          ],
          right: [
            LhAppBarAction.icon(
                onTap: () {
                  widget.controller.maximize();
                },
                icon: Icon(Icons.arrow_upward)),
            LhAppBarAction.icon(
                onTap: () {
                  widget.controller.minimize();
                },
                icon: Icon(Icons.arrow_downward))
          ],
        ));
  }
}
