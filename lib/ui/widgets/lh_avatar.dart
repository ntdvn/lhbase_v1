import 'package:flutter/material.dart';
import 'package:lhbase_v1/lhbase.dart';
import 'package:lhbase_v1/ui/widgets/lh_cached_image.dart';

class LhAvatar extends StatelessWidget {
  final String imageUrl;
  final EdgeInsets? borderRadius;
  final borderColor;
  final double borderWidth;

  final VoidCallback? onEdit;
  final double editHeightFactor;
  final Color? editBackgroundColor;
  final double editIconHeightFactor;
  final Color editIconColor;
  final String? editIconAssetPath;

  final bool isOnline;
  final double onlineFactor;
  final BorderRadius? onlineBorderRadius;
  final BoxBorder? onlineBorder;
  final Color onlineBackgroundColor;

  final VoidCallback? onDelete;
  final double deleteFactor;
  final BorderRadius? deleteBorderRadius;
  final Color deleteBackgroundColor;
  final Color deleteIconColor;

  final double? width;
  final double? height;

  const LhAvatar(
      {Key? key,
      required this.imageUrl,
      this.borderRadius,
      this.borderColor = Colors.black,
      this.borderWidth = 0,
      this.onEdit,
      this.editHeightFactor = 0.3,
      this.editBackgroundColor,
      this.editIconHeightFactor = 0.5,
      this.editIconColor = Colors.white,
      this.editIconAssetPath,
      this.isOnline = false,
      this.onlineFactor = 0.25,
      this.onlineBorderRadius,
      this.onlineBorder,
      this.onlineBackgroundColor = Colors.green,
      this.onDelete,
      this.deleteFactor = 0.4,
      this.deleteBorderRadius,
      this.deleteBackgroundColor = const Color(0xffc9cdcd),
      this.deleteIconColor = Colors.black,
      this.width,
      this.height})
      : super(key: key);

  static final _defaultEditColor = Colors.grey.withOpacity(0.9);
  static final _defaultEditAssetPath = 'assets/images/camera.png';
  static final _defaultOnlineBorder = Border.all(color: Colors.white, width: 1);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20, left: 10),
            width: width,
            height: height,
          ),
          Stack(
            children: [
              ClipRRect(
                child: Stack(
                  children: [
                    if (borderWidth > 0)
                      Positioned.fill(
                          child: ClipRRect(
                        borderRadius: LhValue.circleRadius,
                        child: Container(
                          color: borderColor,
                        ),
                      )),
                    Padding(
                      padding: EdgeInsets.all(borderWidth),
                      child: ClipRRect(
                        borderRadius: LhValue.circleRadius,
                        child: Container(
                            width: width,
                            height: height,
                            child: Container(
                                child:
                                    LhCachedImageWidget(imageUrl: imageUrl))),
                      ),
                    ),
                  ],
                ),
              ),
              if (onEdit != null)
                Positioned.fill(
                    child: ClipRRect(
                  borderRadius: LhValue.circleRadius,
                  child: GestureDetector(
                    onTap: onEdit,
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: FractionallySizedBox(
                        widthFactor: 1,
                        heightFactor: editHeightFactor,
                        child: Container(
                          color: editBackgroundColor ?? _defaultEditColor,
                          child: FractionallySizedBox(
                            heightFactor: editIconHeightFactor,
                            child: Image.asset(
                              editIconAssetPath ?? _defaultEditAssetPath,
                              package: 'lhbase_v1',
                              color: editIconColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
              if (isOnline)
                Positioned.fill(
                    child: Align(
                  alignment: Alignment.bottomRight,
                  child: FractionallySizedBox(
                    widthFactor: onlineFactor,
                    heightFactor: onlineFactor,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              onlineBorderRadius ?? LhValue.circleRadius,
                          color: onlineBackgroundColor,
                          border: onlineBorder ?? _defaultOnlineBorder),
                    ),
                  ),
                )),
            ],
          ),
          if (onDelete != null)
            Positioned.fill(
                child: Align(
              alignment: Alignment.topRight,
              child: FractionallySizedBox(
                widthFactor: deleteFactor,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Card(
                    elevation: 0,
                    color: deleteBackgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: deleteBorderRadius ?? LhValue.circleRadius,
                    ),
                    child: GestureDetector(
                      onTap: onDelete,
                      child: FractionallySizedBox(
                        widthFactor: 0.3,
                        child: Image.asset(
                          'assets/images/close.png',
                          package: 'lhbase_v1',
                          color: deleteIconColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ))
        ],
      ),
    );
  }
}
