import 'package:dio/dio.dart';

class DioCustomInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.onSendProgress = (progress, total) {};
    var data = options.data;
    if (data is FormData) {}

    // if (token != null) {
    //   options.headers.putIfAbsent('Authorization', () => '$token');
    // } else {
    //   print('Auth token is null');
    // }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('Response: ' + response.runtimeType.toString());
    super.onResponse(response, handler);
  }
}
