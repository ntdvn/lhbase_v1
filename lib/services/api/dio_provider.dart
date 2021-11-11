// import 'package:dio/dio.dart';
// import 'package:lhbase_v1/services/api/api.dart';

// import 'endpoint.dart';

// class DioProvider {
//   static Dio instance() {
//     final dio = Dio();
//     dio
//       ..options.baseUrl = Endpoint.BASE_URL
//       ..options.connectTimeout = Endpoint.connectionTimeout
//       ..options.receiveTimeout = Endpoint.receiveTimeout
//       ..options.headers = {
//         // AppStrings.content_type: AppStrings.multipart_form_data
//       }
//       ..interceptors.add(LogInterceptor(
//         request: false,
//         responseBody: false,
//         requestBody: false,
//         requestHeader: false,
//       ))
//       ..interceptors.add(LhDioInterceptor());
//     return dio;
//   }
// }
