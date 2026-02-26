import 'dart:io';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class NetworkApiService {
  final Dio _dio = Dio();
  final Logger _logger = Logger();

  NetworkApiService() {
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          _logger.i('Request [${options.method}] => PATH: ${options.path}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          _logger.i(
            'Response [${response.statusCode}] => PATH: ${response.requestOptions.path}',
          );
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          _logger.e(
            'Error [${e.response?.statusCode}] => PATH: ${e.requestOptions.path}',
          );
          return handler.next(e);
        },
      ),
    );
  }

  Future<dynamic> getGetApiResponse(String url) async {
    try {
      final response = await _dio.get(url);
      return _returnResponse(response);
    } on SocketException {
      throw Exception('No Internet Connection');
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<dynamic> downloadFile(
    String url,
    String savePath, {
    Function(int, int)? onProgress,
  }) async {
    try {
      final response = await _dio.download(
        url,
        savePath,
        onReceiveProgress: onProgress,
      );
      return _returnResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  dynamic _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.data;
      case 400:
        throw Exception('Bad Request: ${response.data.toString()}');
      case 401:
      case 403:
        throw Exception('Unauthorized: ${response.data.toString()}');
      case 500:
        throw Exception('Server Error: ${response.data.toString()}');
      default:
        throw Exception(
          'Error occurred while communicating with server with status code: ${response.statusCode}',
        );
    }
  }

  Exception _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception('Connection timeout');
      case DioExceptionType.badResponse:
        return Exception('Server error: ${error.response?.statusCode}');
      case DioExceptionType.cancel:
        return Exception('Request cancelled');
      default:
        return Exception('Something went wrong');
    }
  }
}
