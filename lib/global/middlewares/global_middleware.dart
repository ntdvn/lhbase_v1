import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlobalMiddleware extends GetMiddleware {
  // final authController = Get.find<AuthController>();
  @override
  RouteSettings? redirect(String? route) {
    print('>>> redirect $route');
    // return RouteSettings(name: route);
    return null;
  }

  @override
  GetPage? onPageCalled(GetPage? page) {
    print('>>> Page ${page!.name} called');
    // print('>>> User ${authController.username} logged');
    return super.onPageCalled(page);
  }

  @override
  List<Bindings>? onBindingsStart(List<Bindings>? bindings) {
    print('onBindingsStart ${bindings} are ready');
    return super.onBindingsStart(bindings);
  }

  @override
  GetPageBuilder? onPageBuildStart(GetPageBuilder? page) {
    print('Bindings of ${page.toString()} are ready');
    return super.onPageBuildStart(page);
  }

  @override
  Widget onPageBuilt(Widget page) {
    print('Widget ${page.toStringShort()} will be showed');
    return super.onPageBuilt(page);
  }

  @override
  void onPageDispose() {
    print('PageDisposed');
    super.onPageDispose();
  }
}
