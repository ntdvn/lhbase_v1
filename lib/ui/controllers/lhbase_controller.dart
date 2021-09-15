import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:lhbase_v1/common/controllers/controllers.dart';

class LhBaseController extends GetxController implements WebServiceAPICallback {
  WebServiceStateController webServiceStateController =
      Get.find<WebServiceStateController>();

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
      Function(Object)? onError}) async {
    webServiceStateController.pushLoading();
    try {
      var result = await api;
      webServiceStateController.popLoading();
      onSuccess(result);
      onAPISuccess(result);
    } catch (e) {
      webServiceStateController.popLoading();
      if (onError != null) onError(e);
      onAPIError(e as DioError, e.requestOptions.path, e.requestOptions.method);
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
  void onAPIError(DioError e, String path, String method) {}
}

abstract class WebServiceAPICallback {
  void onAPISuccess(Object? object);
  void onAPIError(DioError e, String path, String method);
}
