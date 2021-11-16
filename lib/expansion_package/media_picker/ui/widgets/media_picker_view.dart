import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhbase_v1/lhbase.dart';

class MediaPickerView extends StatefulWidget {
  final LhExpanableController viewController;
  final MediaPickerController mediaManagerController;
  final OnMediaSelectedChanged? onSelectedChanged;
  final ValueChanged<List<MediaEntity>>? onSubmitted;
  final VoidCallback? onCameraTap;
  const MediaPickerView(
      {Key? key,
      required this.viewController,
      required this.mediaManagerController,
      this.onSelectedChanged,
      this.onSubmitted,
      this.onCameraTap})
      : super(key: key);

  @override
  _MediaPickerViewState createState() => _MediaPickerViewState();
}

class _MediaPickerViewState extends State<MediaPickerView> {
  LhDropdownViewController _lhDropdownViewController =
      LhDropdownViewController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // _mediaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LhExpanableView(
        controller: widget.viewController,
        child: LhBottomSheetUi(
          child: Stack(
            children: [
              MediaResourceView(
                mediaController: widget.mediaManagerController,
                onSelectedChanged: widget.onSelectedChanged,
                onCameraTap: widget.onCameraTap,
              ),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: GetBuilder<MediaPickerController>(
                        builder: (controller) {
                          return AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            margin: EdgeInsets.only(
                              // bottom: controller.selecteds.isNotEmpty ? 0 : 20,
                              top: controller.selecteds.isNotEmpty
                                  ? MediaQuery.of(context).size.height - 200
                                  : MediaQuery.of(context).size.height,
                            ),
                            child: LhInkwell(
                              onTap: () {
                                if (widget.onSubmitted != null) {
                                  widget.onSubmitted!(controller.selecteds);

                                  widget.viewController.closed();
                                  widget.mediaManagerController
                                      .refreshSelected();
                                }
                              },
                              // color: Colors.blue,

                              decoration: BoxDecoration(color: Colors.blue),
                              borderRadius: BorderRadius.circular(8.0),
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 10),
                                  child: Text(
                                    'Chọn ${controller.selecteds.length} ảnh',
                                    style: LhStyle.DEFAULT_24
                                        .copyWith(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  )),
                            ),
                          );
                        },
                      )))
            ],
          ),
          left: [
            Container(
                margin: EdgeInsets.only(left: 20),
                child: GetBuilder<MediaPickerController>(
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
                              '${controller.gallery != null ? controller.gallery!.name : ''} (${controller.showItemCount})',
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
                          children: List.generate(controller.galleries.length,
                              (index) {
                            return LhInkwell(
                                onTap: () {
                                  widget.mediaManagerController
                                      .changeGallery(index);
                                  _lhDropdownViewController.togglePanel();
                                },
                                child: Text(
                                    '${controller.galleries[index].name} (${controller.galleries[index].assetCount})',
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
            Container(
                padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 10),
                decoration: BoxDecoration(
                    color: Color(0xFF3C3C3C),
                    borderRadius: BorderRadius.circular(5)),
                child: GetBuilder<MediaPickerController>(
                  builder: (controller) {
                    return Text(
                      '${controller.selecteds.length} / ${controller.number}',
                      style: LhStyle.DEFAULT_14.copyWith(color: Colors.white),
                    );
                  },
                )),
            LhAppBarAction.icon(
                sizeFactor: 1.0,
                onTap: () {
                  widget.viewController.closed();
                },
                icon: Icon(Icons.close)),
          ],
        ));
  }
}
