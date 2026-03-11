import 'dart:io';
import 'package:dio/dio.dart';
import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';

import 'package:video_downloder/core/utils/app_url/app_url.dart';

class DownloadService {
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 120),
  ));

  static bool _isProxyRequired(String url) {
    final lower = url.toLowerCase();
    return lower.contains('pinimg.com') || lower.contains('pinterest');
  }

  Future<void> downloadAndSaveVideo({
    required String url,
    required String fileName,
    required Function(double progress) onProgress,
  }) async {
    try {
      // 1. Request Permission
      final hasAccess = await Gal.hasAccess();
      if (!hasAccess) {
        final granted = await Gal.requestAccess();
        if (!granted) {
          throw Exception("Storage permission denied");
        }
      }

      // 2. Get Application Documents Directory (more persistent than temporary)
      final appDir = await getApplicationDocumentsDirectory();
      final savePath = '${appDir.path}/$fileName';
      print("DownloadService: savePath: $savePath");

      // 3. Construct Download URL
      // We only apply the proxy if the URL isn't already pointing to our backend proxy.
      String downloadUrl = url;
      if (!url.startsWith(AppUrl.baseUrl)) {
        final encodedUrl = Uri.encodeComponent(url);
        downloadUrl = '${AppUrl.proxy}$encodedUrl';
        print("DownloadService: Routing through universal proxy -> $downloadUrl");
      } else {
        print("DownloadService: Using direct backend URL -> $downloadUrl");
      }

      // 4. Download File
      try {
        final response = await _dio.download(
          downloadUrl,
          savePath,
          options: Options(
            // connectTimeout: const Duration(seconds: 30),
            // receiveTimeout: const Duration(seconds: 120),
            headers: {
              'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
            },
          ),
          onReceiveProgress: (count, total) {
            if (total != -1) {
              onProgress(count / total);
            }
          },
        );
        print("DownloadService: Download status: ${response.statusCode}");
      } catch (e) {
        if (_isProxyRequired(url)) {
          print("DownloadService: Proxy failed for proxy-required URL (e.g. Pinterest). No direct fallback.");
          rethrow;
        }
        print("DownloadService: Proxy failed, attempting direct download as fallback... Error: $e");
        await _dio.download(
          url,
          savePath,
          options: Options(
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 120),
            headers: {
              'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
              'Accept': 'video/mp4,video/mov,video/webm,video/mkv,video/avi,video/flv,video/3gp,video/mpeg,video/quicktime',
            },
          ),
          onReceiveProgress: (count, total) {
            if (total != -1) {
              onProgress(count / total);
            }
          },
        );
      }
      
      final file = File(savePath);
      if (await file.exists()) {
        print("DownloadService: File exists at $savePath, size: ${await file.length()}");
      } else {
        print("DownloadService: File DOES NOT exist at $savePath");
      }

      // 4. Save to Gallery
      print("DownloadService: Saving to gallery using Gal (Album: ReelDrop)...");
      await Gal.putVideo(savePath, album: "ReelDrop");
      print("DownloadService: Saved to gallery successfully!");

      // 5. Clean up temp file (Wait a bit to ensure gallery indexing is triggered)
      await Future.delayed(const Duration(milliseconds: 500));
      if (await file.exists()) {
        await file.delete();
        print("DownloadService: Temp file deleted.");
      }
    } catch (e) {
      print("DownloadService: Error during download/save: $e");
      rethrow;
    }
  }
}
