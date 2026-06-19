 
import '../../models/extract_model/exract_request.dart';
import '../../models/extract_model/extract_response.dart';

abstract class LinkDropApiRepositry {
  Future<ExtractResponse> extractVideo(ExractRequest  request);
  Future<ExtractResponse> fetchVideoInfo(ExractRequest  request);
}
