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
  LhExpanableController _lhExpanableController =
      LhExpanableController(minimizeHeight: 300);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        LhBasePage(
            child: Container(
          child: TextButton(
            onPressed: () {
              _lhExpanableController.minimize();
            },
            child: Text('open'),
          ),
        )),
        LhExpanableView(
            controller: _lhExpanableController,
            child: LhBottomSheetUi(
              child: MediaSelectPage(
                type: MediaSelectType.MULTIPLE,
                number: 2,
              ),
              title: "Chọn Ảnh",
              right: [
                LhAppBarAction.icon(
                    onTap: () {
                      _lhExpanableController.maximize();
                    },
                    icon: Icon(Icons.arrow_upward)),
                     LhAppBarAction.icon(
                    onTap: () {
                      _lhExpanableController.minimize();
                    },
                    icon: Icon(Icons.arrow_downward))
              ],
            ))
      ],
    );
  }
}
