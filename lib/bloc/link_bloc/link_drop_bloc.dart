import 'package:dio/dio.dart';
 
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/extract_model/exract_request.dart';
import '../../repository/link_drop_api/link_drop_repositry.dart';
import '../../services/fetching_service/fetching_service.dart';
import 'link_drop_event.dart';
import 'link_drop_state.dart';

class LinkDropBloc extends Bloc<LinkDropEvent , LinkDropState> {
  final LinkDropApiRepositry _apiRepositry;
  final  _fetchService = FetchingService();

  LinkDropBloc(this._apiRepositry) : super(LinkDropInitial()) {
    on<FetchVideoData>(_onFetchVideoData);
    on<ExtrackingVideo>(_onExtractVideo);
  }

  Future<void> _onFetchVideoData(FetchVideoData event, Emitter<LinkDropState> emit) async {
    emit(LinkDropLoading());
    try {
      final response = await _apiRepositry.extractVideo(
        ExractRequest (url: event.url),
      );
      if (response.success == true) {
        emit(LinkDropLoaded(extractResponse: response));
      } else {
        emit(LinkDropError(error: "Fetch not accessible. Try another link."));
      }
    } catch (e) {
      String errorMessage = _mapErrorToMessage(e);
      emit(LinkDropError(error: errorMessage));
    }
  }

  Future<void>_onExtractVideo(ExtrackingVideo event, Emitter<LinkDropState> emit) async {
    final currentResponse = state.extractResponse;
    emit(LinkDropExtracting(currentProgress: 0.0, extractResponse: currentResponse));
    
    try {
      final sanitized = event.title.replaceAll(RegExp(r'[^\w\s]+'), '_').replaceAll(RegExp(r'_+'), '_').trim();
      const maxLength = 150; // Avoid "File name too long" (errno 36)
      String baseName = sanitized.length > maxLength ? sanitized.substring(0, maxLength).trimRight() : sanitized;
      if (baseName.isEmpty || RegExp(r'^_+$').hasMatch(baseName)) {
        final safeUploader = (event.uploader ?? 'video').replaceAll(RegExp(r'[^\w\s]+'), '_').trim();
        baseName = '${safeUploader.isNotEmpty ? safeUploader : 'video'}_${DateTime.now().millisecondsSinceEpoch}';
      }
      final fileName = '$baseName.${event.ext}';
      await _fetchService.fetchAndSaveVideo(
        url: event.videoUrl,
        fileName: fileName,
        onProgress: (progress) {
          emit(LinkDropExtracting(currentProgress: progress, extractResponse: currentResponse));
        },
      );
      emit(LinkDropExtract());
    } catch (e) {
      String errorMessage = _mapErrorToMessage(e);
      final isPinterest = (event.videoUrl.toLowerCase().contains('pinimg.com') ||
          event.videoUrl.toLowerCase().contains('pinterest'));
      if (isPinterest && errorMessage.contains('Network error')) {
        errorMessage = "Pinterest proxy failed. Please try again or ensure the server is reachable.";
      }
      emit(LinkDropError(error: "Fetched failed: $errorMessage"));
    }
  }

  String _mapErrorToMessage(dynamic e) {
    final eString = e.toString().toLowerCase();
    if (eString.contains('bot') || eString.contains('robot') || eString.contains('sign in to confirm')) {
      return "YOUTUBE_BOT_DETECTION";
    }

    if (e is DioException) {
      if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout) {
        return "Connection timed out. Check your internet.";
      } else if (e.response?.statusCode == 500) {
        return "Server error. This video platform might be down.";
      } else if (e.response?.statusCode == 404) {
        return "Video not found. Please check the URL.";
      } else if (e.response?.statusCode == 403) {
        return "This platform blocks direct downloads. Try again or use another link.";
      }
      return "Network error. Please try again.";
    }
    return "Something went wrong. Please try again.";
  }
}
