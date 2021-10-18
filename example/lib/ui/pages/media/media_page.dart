import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lhbase_v1/expansion_package/media_manager/ui/ui.dart';
import 'package:lhbase_v1/lhbase.dart';
import 'package:lhbase_v1/ui/ui.dart';

class MediaPage extends StatefulWidget {
  const MediaPage({Key? key}) : super(key: key);

  @override
  _MediaPageState createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> {
  late LhExpanableController _lhExpanableController;
  List<MediaEntity> mediaEntities = [];

  @override
  void initState() {
    _lhExpanableController = LhExpanableController(minimizeHeight: 300);
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
                        _lhExpanableController.minimize();
                      },
                      child: Text('open'),
                    ),
                    ...List.generate(mediaEntities.length, (index) {
                      return FutureBuilder<File?>(
                        future: mediaEntities[index].assetEntity.originFile,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Container(height: 100, child: Image.file(snapshot.data!,));
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
          controller: _lhExpanableController,
          onSelectedChanged: (value) {
            setState(() {
              mediaEntities = value;
              print('mediaEntities $mediaEntities');
            });
          },
        )
      ],
    );
  }
}
