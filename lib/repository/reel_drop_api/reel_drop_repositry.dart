import 'package:video_downloder/models/download_model/download_request.dart';
import 'package:video_downloder/models/download_model/download_response.dart';

abstract class ReelDropApiRepositry {
  Future<DownloadResponse> downloadVideo(DownloadRequest request);
  Future<DownloadResponse> fetchVideoInfo(DownloadRequest request);
}
