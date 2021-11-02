import 'package:flutter/material.dart';
import 'package:lhbase_v1/lhbase.dart';

class LhStoryContent extends StatefulWidget {
  final StoryData data;
  final VoidCallback? onReady;
  const LhStoryContent({
    Key? key,
    required this.data,
    this.onReady,
  }) : super(key: key);

  @override
  _LhStoryContentState createState() => _LhStoryContentState();
}

class _LhStoryContentState extends State<LhStoryContent> {
  @override
  Widget build(BuildContext context) {
    return Container(child: _buildContent());
  }

  Widget _buildContent() {
    if (widget.data.image != null) {
      return Stack(
        children: [
          if (widget.data.imageBytes != null)
            Positioned.fill(
              child: Image.memory(
                widget.data.imageBytes!,
                fit: BoxFit.cover,
              ),
            )
          else
            Center(child: CircularProgressIndicator())
        ],
      );
    }
    if (widget.data.widget != null) {
      return Container(
        child: widget.data.widget,
      );
    }
    return Container();
  }
}
