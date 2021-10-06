import 'package:flutter/material.dart';

class LhStoryProgressBar extends StatelessWidget {
  final double? progress;
  const LhStoryProgressBar({Key? key, this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(500.0),
      child: LinearProgressIndicator(
        value: progress ?? 0,
        semanticsLabel: 'Linear progress indicator',
        minHeight: 10,
        backgroundColor: Colors.grey,
        color: Colors.white,
      ),
    );
  }
}
