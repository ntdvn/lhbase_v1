import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lhbase_v1/lhbase.dart';

class LhBaseController extends GetxController implements WebServiceAPICallback {
  LhSessionRepository lhSessionRepository = Get.find<LhSessionRepository>();
  WebServiceStateController webServiceStateController =
      Get.find<WebServiceStateController>();
  // var lhCommonRepository = Get.find(tag: 'commonRepository');

  RxInt loading = RxInt(0);

  _pushLoading() {
    loading.value++;
  }

  _popLoading() {
    loading.value > 0 ? loading.value-- : loading.value = 0;
  }

  bool isLoading() {
    return loading.value > 0;
  }

  Future<void> callApi<T>(
      {required Future<T> api,
      required Function(T) onSuccess,
      Widget? childLoading,
      Widget? widgetTimeOut,
      Function(Object)? onError}) async {
      webServiceStateController.pushLoading(childLoading: childLoading);
    try {
      var result = await api;
      webServiceStateController.popLoading();
      onSuccess(result);
      onAPISuccess(result);
    } catch (e) {
      webServiceStateController.popLoading();
      if (onError != null) onError(e);
      onAPIError(e as DioError, e.requestOptions.path, e.requestOptions.method, timeout :widgetTimeOut);
    }
    return;
  }

  Future<void> callApiNotLoading<T>(
      {required Future<T> api,
      required Function(T) onSuccess,
      Widget? widgetTimeOut,
      Function(Object)? onError}) async {
    try {
      var result = await api;
      onSuccess(result);
      onAPISuccess(result);
    } catch (e) {
      if (onError != null) onError(e);
      onAPIError(e as DioError, e.requestOptions.path, e.requestOptions.method, timeout :widgetTimeOut);
    }
    return;
  }

  callApiLocalLoading<T>(
      {required Future<T> api,
      required Function(T) onSuccess,
      Function(Object)? onError}) async {
    _pushLoading();
    try {
      var result = await api;
      _popLoading();
      onSuccess(result);
    } catch (e) {
      _popLoading();
      if (onError != null) onError(e);
    }
  }

  @override
  void onAPISuccess(Object? object) {}

  @override
  void onAPIError(DioError e, String path, String method, {Widget? timeout}) {
    if(e.type == DioErrorType.connectTimeout){
      webServiceStateController.pushTimeout(timeout: timeout);
    }
  }
}

abstract class WebServiceAPICallback {
  void onAPISuccess(Object? object);
  void onAPIError(DioError e, String path, String method);
}
