import 'package:dio/dio.dart';
import 'package:lhbase_v1/lhbase.dart';

class LhDioInterceptor extends Interceptor {
  final String tokenPrefix;

  LhDioInterceptor({this.tokenPrefix = ''});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.onSendProgress = (progress, total) {};
    var data = options.data;
    if (data is FormData) {}

    var prefs = LhbasePref();
    var token = await prefs.getString(LhbasePref.auth_token);
    if (token != null) {
      options.headers.putIfAbsent('Authorization', () => '$tokenPrefix$token');
    } else {
      print('-----Auth token is null-----');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('Response: ' + response.runtimeType.toString());
    super.onResponse(response, handler);
  }
}
