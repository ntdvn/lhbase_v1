import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MediaLoading extends StatelessWidget {
  const MediaLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Center(
    //   child: SizedBox.fromSize(
    //     size: Size.square(30),
    //     child: (Platform.isIOS || Platform.isMacOS)
    //         ? CupertinoActivityIndicator()
    //         : CircularProgressIndicator(),
    //   ),
    // );
    return Container(
      color: Colors.grey,
    );
  }
}
