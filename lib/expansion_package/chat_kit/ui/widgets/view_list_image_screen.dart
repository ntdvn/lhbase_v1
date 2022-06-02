// ignore: import_of_legacy_library_into_null_safe
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lhbase_v1/lhbase.dart';
import 'package:lhbase_v1/res/lh_styles.dart';
import 'package:lhbase_v1/res/res.dart';
import 'package:lhbase_v1/ui/widgets/widgets.dart';

class ViewListNetworkImageScreen extends StatefulWidget {
  final List<String>? listImage;
  final int? initIndex;

  const ViewListNetworkImageScreen({Key? key, this.listImage, this.initIndex}) : super(key: key);
  @override
  _ViewListNetworkImageScreenState createState() => _ViewListNetworkImageScreenState();
}

class _ViewListNetworkImageScreenState extends State<ViewListNetworkImageScreen> {

  SwiperController swiperController = SwiperController();

  @override
  void initState() {
    swiperController.addListener(() { });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LhBasePage(
        appBarTop: LhAppBar.top(
          backgroundColor: Colors.black,
          leadingColor: Colors.white,
        ),
        appBarBottom: LhAppBar.bottomEmpty(
          backgroundColor: Colors.black,
        ),
        child: Container(
          height: Get.width,
          child: widget.listImage != null && widget.listImage!.isNotEmpty ? Swiper(
            controller: swiperController,
            itemBuilder: (BuildContext context, int index) {
              return WidgetNetworkImage(
                image: widget.listImage![index],
                height: Get.width,
                width: Get.width,
                borderRadius: 0,
                fit: BoxFit.fitWidth,
                boxDecoration: BoxDecoration(
                    color: Colors.black
                ),
              );
            },
            indicatorLayout: PageIndicatorLayout.COLOR,
            control: const SwiperControl(),
            autoplay: false,
            loop: false,
            itemCount: widget.listImage!.length,
            index: widget.initIndex,
          )
              : Container(
          color: Colors.black,
          child: Center(child: LhText('Lỗi tải ảnh', style: LhStyle.DEFAULT_16.copyWith(color: Colors.white),)),
        ),
        ),
    );
  }
}


class WidgetNetworkImage extends StatelessWidget {
  final double? width, height, borderRadius;
  final BorderRadius? borderRadiusCustom;
  final String image;
  final BoxDecoration? boxDecoration;
  final BoxFit? fit;
  final GestureTapCallback? onTap;

  const WidgetNetworkImage(
      {this.width, this.height, this.borderRadius, this.borderRadiusCustom, required this.image,
        this.boxDecoration,
        this.onTap,
        this.fit = BoxFit.fill});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecoration,
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: borderRadiusCustom == null ? BorderRadius.circular(borderRadius ?? 100) : borderRadiusCustom,
          child: CachedNetworkImage(
            imageUrl: image,
            fit: fit,
            height: height,
            width: width,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: fit,
                ),
              ),
            ),
            placeholder: (context, url) => CupertinoActivityIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}