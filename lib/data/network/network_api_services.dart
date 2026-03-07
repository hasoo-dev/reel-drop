import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:video_downloder/data/network/base_api_services.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:logger/logger.dart';

import '../exception/app_exception.dart';

/// Class for handling network API requests.
class NetworkApiService implements BaseApiServices {
  final Logger _logger = Logger();
 
  @override
  Future<dynamic> getApi(String url) async {
    if (kDebugMode) {
      print('GET Request: $url');
    }
    final stopwatch = Stopwatch()..start();
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 120));
      stopwatch.stop();
      if (kDebugMode) {
        print('GET Response from $url took ${stopwatch.elapsed.inSeconds} seconds');
      }
      responseJson = returnResponse(response);
    } on SocketException catch (e) {
      _logger.e('SocketException (GET): ${e.message}, host: ${e.address?.host}, port: ${e.port}');
      throw NoInternetException('Cannot reach server at ${Uri.parse(url).host}. Check IP/Firewall.');
    } on TimeoutException {
      _logger.e('TimeoutException (GET) after ${stopwatch.elapsed.inSeconds}s for URL: $url');
      throw FetchDataException('Network Timeout (120s) for ${Uri.parse(url).host}. Server not responding.');
    }

    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson;
  }

  /// Sends a POST request to the specified [url] with the provided [data]
  /// and returns the response.
  @override
  Future<dynamic> postApi(String url, dynamic data) async {
    if (kDebugMode) {
      print('POST Request: $url');
      print('Body: $data');
    }
    final stopwatch = Stopwatch()..start();
    dynamic responseJson;
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
          'Referer': 'https://www.google.com/',
        },
        body: jsonEncode(data),
      ).timeout(const Duration(seconds: 30));
      
      stopwatch.stop();
      if (kDebugMode) {
        print('POST Response from $url took ${stopwatch.elapsed.inSeconds} seconds');
      }
      responseJson = returnResponse(response);
    } on SocketException catch (e) {
      _logger.e('SocketException (POST): ${e.message}, host: ${e.address?.host}, port: ${e.port}');
      throw NoInternetException('Cannot reach server at ${Uri.parse(url).host}. Ensure PC and Phone are on same WiFi.');
    } on TimeoutException {
      _logger.e('TimeoutException (POST) after ${stopwatch.elapsed.inSeconds}s for URL: $url');
      throw FetchDataException('Network Timeout (120s). PC at ${Uri.parse(url).host} might be blocking connections.');
    }

    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson;
  }

  /// Parses the [response] and returns the corresponding JSON data.
  dynamic returnResponse(http.Response response) {
    if (kDebugMode) {
      print('Status Code: ${response.statusCode}');
    }

    switch (response.statusCode) {
      case 200:
      case 400:
        return jsonDecode(response.body);
      case 401:
        throw BadRequestException(response.body.toString());
      case 500:
      case 404:
        throw UnauthorisedException(response.body.toString());
      default:
        _logger.w('Unexpected Status Code: ${response.statusCode}, Body: ${response.body}');
        throw FetchDataException('Error communicates with server (${response.statusCode})');
    }
  }
}