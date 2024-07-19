import 'dart:io';
import 'package:dio/dio.dart';
import '../resources/constant_methods.dart';
import 'api_constants.dart';
import 'api_result_handler.dart';

class NetworkDio {
  late Dio dio;

  NetworkDio() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.urlGitHub,
        receiveDataWhenStatusError: true,
        receiveTimeout: const Duration(milliseconds: 30000),
        connectTimeout: const Duration(milliseconds: 30000),
      ),
    );
    printTest('dio');
  }

  Future<ApiResults> getData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    dio.options.headers = {
      "Content-Type": "application/json",
    };
    return _performRequest(
          () => dio.get(endPoint, queryParameters: queryParameters),
      additionalInfo: {
        'endpoint': endPoint,
        'queryParameters': queryParameters,
      },
    );
  }

  Future<ApiResults> postData({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    bool formData = true,
  }) async {
    dio.options.headers = {
      "Accept": "application/json",
    };

    return _performRequest(
          () => dio.post(
        endPoint,
        data: formData ? FormData.fromMap(data ?? {}) : data,
        queryParameters: queryParameters,
      ),
      additionalInfo: {
        'endpoint': endPoint,
        'data': data,
        'queryParameters': queryParameters,
      },
    );
  }

  Future<ApiResults> _performRequest(
      Future<Response> Function() request, {
        Map<String, dynamic>? additionalInfo,
      }) async {
    try {
      var response = await request();
      _logResponse(response, additionalInfo);
      return ApiSuccess(response.data, response.statusCode);
    } on SocketException {
      return ApiFailure("No internet connection");
    } on FormatException {
      return ApiFailure("An error occurred in the data format");
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return ApiFailure("$e An error occurred, try again");
    }
  }

  void _logResponse(Response response, Map<String, dynamic>? additionalInfo) {
    printResponse('base: ${dio.options.baseUrl}');
    printResponse('url: ${additionalInfo?['endpoint']}');
    printResponse('header: ${dio.options.headers}');
    if (additionalInfo != null) {
      additionalInfo.forEach((key, value) {
        printResponse('$key: $value');
      });
    }
    printResponse('response: $response');
  }

  ApiFailure _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ApiFailure("Check your connection");
      case DioExceptionType.receiveTimeout:
        return ApiFailure("Unable to connect to the server");
      case DioExceptionType.unknown:
        return ApiFailure(e.message ?? 'Something went wrong');
      default:
        return ApiFailure("An error occurred, try again");
    }
  }
}
