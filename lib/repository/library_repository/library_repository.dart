import 'dart:io';
import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_downloder/data/network/network_api_service.dart';

class LibraryRepository {
  final NetworkApiService _apiService = NetworkApiService();

  Future<bool> requestPermissions() async {
    if (Platform.isAndroid) {
      final status = await Permission.storage.request();
      final statusMedia = await Permission.videos.request();
      return status.isGranted || statusMedia.isGranted;
    } else {
      final status = await Permission.photos.request();
      return status.isGranted;
    }
  }

  Future<void> downloadVideo({
    required String url,
    required String fileName,
    required Function(int, int) onProgress,
  }) async {
    try {
      // 1. Check Permissions
      final hasPermission = await requestPermissions();
      if (!hasPermission) {
        throw Exception('Storage permission denied');
      }

      // 2. Get Temporary Directory
      final tempDir = await getTemporaryDirectory();
      final savePath = '${tempDir.path}/$fileName';

      // 3. Download File
      await _apiService.downloadFile(url, savePath, onProgress: onProgress);

      // 4. Save to Gallery
      await Gal.putVideo(savePath);

      // 5. Clean up temp file
      final file = File(savePath);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      rethrow;
    }
  }
}
