import 'package:flutter/material.dart';
import 'package:lhbase_v1/lhbase.dart';

class LhStoryContent extends StatefulWidget {
  final Story story;
  final VoidCallback? onReady;
  const LhStoryContent({
    Key? key,
    required this.story,
    this.onReady,
  }) : super(key: key);

  @override
  _LhStoryContentState createState() => _LhStoryContentState();
}

class _LhStoryContentState extends State<LhStoryContent> {
  @override
  void initState() {
    _isReady = false;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // widget.storyController.pause();
    // print('hehe');
    //  widget.storyController.play();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: _renderByContent());
  }

  @override
  void didUpdateWidget(covariant LhStoryContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    // if (_imageIsLoaded) {
    //   widget.storyController.play();
    // } else {}
    // print('update');
  }

  bool _imageIsLoaded = false;

  bool _isReady = false;

  Widget _renderByContent() {
    // print('_isReady $_isReady | widget.onReady ${widget.onReady}');
    if (widget.story.image != null) {
      return Image.network(
        widget.story.image!,
        fit: BoxFit.cover,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            // print('null nay $_imageIsLoaded');
            if (_imageIsLoaded)
              return child;
            else
              return Center(child: CircularProgressIndicator());
            // return child;
          } else {
            // print('progesss');
            if (loadingProgress.expectedTotalBytes != null) {
              var value = loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes!;
              if (loadingProgress.cumulativeBytesLoaded ==
                  loadingProgress.expectedTotalBytes) {
                _imageIsLoaded = true;
                if (widget.onReady != null) widget.onReady!();
              }
              return Center(
                  child: CircularProgressIndicator(
                value: value,
              ));
            }
            return Center(child: CircularProgressIndicator());
          }
        },
      );
    } else if (widget.story.widget != null) {
      // print('!!! _isReady $_isReady | widget.onReady ${widget.onReady}');
      if (widget.onReady != null && _isReady == false) {
        _isReady = true;
        widget.onReady!();

        // print('_isReady $_isReady | widget.onReady ${widget.onReady}');
        return widget.story.widget!;
      }

      return widget.story.widget!;
    }
    return Container();
  }
}
