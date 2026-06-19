 

import 'package:link_drop/repository/link_drop_api/link_drop_repositry.dart';
import '../../core/utils/app_url/app_url.dart';
import '../../data/network/network.dart';
import '../../models/extract_model/exract_request.dart';
import '../../models/extract_model/extract_response.dart';

class LinkDropApiRepositryImpl implements LinkDropApiRepositry {
  final BaseApiServices _apiServices = NetworkApiService();

  @override
  Future<ExtractResponse>  extractVideo(ExractRequest  request) async {
    try {
      dynamic response = await _apiServices.postApi(
        AppUrl.download,
        request.toJson(),
      );
      return ExtractResponse.fromJson(response);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<ExtractResponse> fetchVideoInfo(ExractRequest request) async {
    try {
      dynamic response = await _apiServices.postApi(
        AppUrl.info,
        request.toJson(),
      );
      return ExtractResponse.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}