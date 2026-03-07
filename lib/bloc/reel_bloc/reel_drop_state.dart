import 'package:video_downloder/models/download_model/download_response.dart';

sealed class ReelDropState {
  final DownloadResponse? downloadResponse;
  final String? error;
  final double progress;
  
  ReelDropState({this.downloadResponse, this.error, this.progress = 0.0});
}

class ReelDropInitial extends ReelDropState {}

class ReelDropLoading extends ReelDropState {}

class ReelDropLoaded extends ReelDropState {
  ReelDropLoaded({required DownloadResponse downloadResponse}) 
      : super(downloadResponse: downloadResponse);
}

class ReelDropDownloading extends ReelDropState {
  final double currentProgress;
  ReelDropDownloading({required this.currentProgress, DownloadResponse? downloadResponse}) 
      : super(downloadResponse: downloadResponse, progress: currentProgress);
}

class ReelDropDownloaded extends ReelDropState {
  ReelDropDownloaded() : super();
}

class ReelDropError extends ReelDropState {
  ReelDropError({required String error}) : super(error: error);
}