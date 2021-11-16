import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhbase_v1/lhbase.dart';
import 'package:lhbase_v1/ui/ui.dart';

class MediaPage extends StatefulWidget {
  const MediaPage({Key? key}) : super(key: key);

  @override
  _MediaPageState createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> {
  late LhExpanableController _lhExpanableController;
  late MediaPickerController _mediaController;
  List<MediaEntity> mediaEntities = [];

  @override
  void initState() {
    _lhExpanableController = LhExpanableController(minimizeHeight: 300);
    Get.lazyPut(
        () => MediaPickerController(
            mediaType: MediaPickerType.IMAGE, number: 0, cameraPicker: true),
        fenix: true);
    _mediaController = Get.find<MediaPickerController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        LhBasePage(
            appBarTop: LhAppBar.top(),
            child: Container(
              child: SingleChildScrollView(
                child: Wrap(
                  children: [
                    TextButton(
                      onPressed: () {
                        _lhExpanableController.maximize();
                      },
                      child: Text('open'),
                    ),
                    ...List.generate(mediaEntities.length, (index) {
                      return FutureBuilder<File?>(
                        future: mediaEntities[index].assetEntity.originFile,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                                height: 100,
                                child: Image.file(
                                  snapshot.data!,
                                ));
                          }
                          return Container();
                        },
                      );
                    })
                  ],
                ),
              ),
            )),
        MediaPickerView(
            viewController: _lhExpanableController,
            mediaManagerController: _mediaController,
            // onSubmitted: (value) {
            //   setState(() {
            //     mediaEntities = value;
            //     print('onSubmitted ${mediaEntities.length}');
            //   });
            // },
            // onSelectedChanged: (value) {
            //    setState(() {
            //     mediaEntities = value;
            //     print('onSubmitted ${mediaEntities.length}');
            //   });
            // },
            onSubmitted: (value) {
              setState(() {
                mediaEntities.clear();
                mediaEntities.addAll(value);
              });
            },
            onSelectedChanged: (selected, entities) {
              print('selected $selected');
              print('entities $entities');
            },
            onCameraTap: () {
              print("object");
            })
      ],
    );
  }
}
