import 'package:dio/dio.dart';
import 'package:flutter/material.dart' as Material;

class DioErrorUtils {
  static String getErrorMessage(int code) {
    var errorType = '';
    var errorMessage = '';
    switch (code) {
      // CLIENT
      case 400:
        errorType = 'Client error';
        errorMessage = 'Bad Request';
        break;
      case 401:
        errorType = 'Client error';
        errorMessage = 'Unauthorized';
        break;
      case 402:
        errorType = 'Client error';
        errorMessage = 'Payment Required';
        break;
      case 403:
        errorType = 'Client error';
        errorMessage = 'Forbidden';
        break;
      case 404:
        errorMessage = 'Not Found';
        break;
      case 405:
        errorType = 'Client error';
        errorMessage = 'Method Not Allowed';
        break;
      case 406:
        errorType = 'Client error';
        errorMessage = 'Not Acceptable';
        break;
      case 407:
        errorType = 'Client error';
        errorMessage = 'Proxy Authentication Required';
        break;
      case 408:
        errorType = 'Client error';
        errorMessage = 'Request Timeout';
        break;
      // SERVER
      case 500:
        errorType = 'Server error';
        errorMessage = 'Internal Server Error';
        break;
      case 501:
        errorType = 'Server error';
        errorMessage = 'Not Implemented';
        break;
      case 502:
        errorType = 'Server error';
        errorMessage = 'Bad Gateway';
        break;
      case 503:
        errorType = 'Server error';
        errorMessage = 'Service Unavailable';
        break;
      case 504:
        errorType = 'Server error';
        errorMessage = 'Gateway Timeout';
        break;
      case 505:
        errorType = 'Server error';
        errorMessage = 'HTTP Version Not Supported';
        break;
      default:
        errorType = 'Unknown';
        errorMessage = 'Unknown';
    }
    return '$errorType: $errorMessage\nCode: $code';
  }

  static handlerError(DioError error,
      {Material.VoidCallback? onUnauthorizedNavigate,
      Function(String errorMessage)? onErrorHandler}) {
    String errorMessage = '';

    if (error.type == DioErrorType.response) {
      var httpStatusCode = error.response!.statusCode!;
      errorMessage = getErrorMessage(httpStatusCode);

      if (httpStatusCode == 401) {
        if (onUnauthorizedNavigate != null) onUnauthorizedNavigate();
      }
    }
    errorMessage = error.message;
    if (onErrorHandler != null) onErrorHandler(errorMessage);
  }
}
