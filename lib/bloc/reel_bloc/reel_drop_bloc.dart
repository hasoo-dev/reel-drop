import 'package:dio/dio.dart';
import 'package:video_downloder/bloc/reel_bloc/reel_drop_event.dart';
import 'package:video_downloder/bloc/reel_bloc/reel_drop_state.dart';
import 'package:video_downloder/models/download_model/download_request.dart';
import 'package:video_downloder/repository/reel_drop_api/reel_drop_repositry.dart';
import 'package:video_downloder/services/download_service/download_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReelDropBloc extends Bloc<ReelDropEvent, ReelDropState> {
  final ReelDropApiRepositry _apiRepositry;
  final DownloadService _downloadService = DownloadService();

  ReelDropBloc(this._apiRepositry) : super(ReelDropInitial()) {
    on<FetchVideoData>(_onFetchVideoData);
    on<DownloadVideo>(_onDownloadVideo);
  }

  Future<void> _onFetchVideoData(FetchVideoData event, Emitter<ReelDropState> emit) async {
    emit(ReelDropLoading());
    try {
      final response = await _apiRepositry.downloadVideo(
        DownloadRequest(url: event.url),
      );
      if (response.success == true) {
        emit(ReelDropLoaded(downloadResponse: response));
      } else {
        emit(ReelDropError(error: "Video not accessible. Try another link."));
      }
    } catch (e) {
      String errorMessage = _mapErrorToMessage(e);
      emit(ReelDropError(error: errorMessage));
    }
  }

  Future<void> _onDownloadVideo(DownloadVideo event, Emitter<ReelDropState> emit) async {
    final currentResponse = state.downloadResponse;
    emit(ReelDropDownloading(currentProgress: 0.0, downloadResponse: currentResponse));
    
    try {
      final sanitized = event.title.replaceAll(RegExp(r'[^\w\s]+'), '_').replaceAll(RegExp(r'_+'), '_').trim();
      const maxLength = 150; // Avoid "File name too long" (errno 36)
      String baseName = sanitized.length > maxLength ? sanitized.substring(0, maxLength).trimRight() : sanitized;
      if (baseName.isEmpty || RegExp(r'^_+$').hasMatch(baseName)) {
        final safeUploader = (event.uploader ?? 'video').replaceAll(RegExp(r'[^\w\s]+'), '_').trim();
        baseName = '${safeUploader.isNotEmpty ? safeUploader : 'video'}_${DateTime.now().millisecondsSinceEpoch}';
      }
      final fileName = '$baseName.${event.ext}';
      await _downloadService.downloadAndSaveVideo(
        url: event.videoUrl,
        fileName: fileName,
        onProgress: (progress) {
          emit(ReelDropDownloading(currentProgress: progress, downloadResponse: currentResponse));
        },
      );
      emit(ReelDropDownloaded());
    } catch (e) {
      String errorMessage = _mapErrorToMessage(e);
      final isPinterest = (event.videoUrl.toLowerCase().contains('pinimg.com') ||
          event.videoUrl.toLowerCase().contains('pinterest'));
      if (isPinterest && errorMessage.contains('Network error')) {
        errorMessage = "Pinterest proxy failed. Please try again or ensure the server is reachable.";
      }
      emit(ReelDropError(error: "Download failed: $errorMessage"));
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
