import 'package:video_downloder/core/utils/app_url/app_url.dart';
import 'package:video_downloder/data/network/base_api_services.dart';
import 'package:video_downloder/data/network/network_api_services.dart';
import 'package:video_downloder/models/download_model/download_request.dart';
import 'package:video_downloder/models/download_model/download_response.dart';
import 'package:video_downloder/repository/reel_drop_api/reel_drop_repositry.dart';

class ReelDropApiRepositryImpl implements ReelDropApiRepositry {
  final BaseApiServices _apiServices = NetworkApiService();

  @override
  Future<DownloadResponse> downloadVideo(DownloadRequest request) async {
    try {
      dynamic response = await _apiServices.postApi(
        AppUrl.download,
        request.toJson(),
      );
      return DownloadResponse.fromJson(response);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<DownloadResponse> fetchVideoInfo(DownloadRequest request) async {
    try {
      dynamic response = await _apiServices.postApi(
        AppUrl.info,
        request.toJson(),
      );
      return DownloadResponse.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}