 

import '../../models/extract_model/extract_response.dart';

sealed class LinkDropState {
  final ExtractResponse? extractResponse;
  final String? error;
  final double progress;
  
  LinkDropState({this.extractResponse, this.error, this.progress = 0.0});
}

class LinkDropInitial extends LinkDropState {}

class LinkDropLoading extends LinkDropState {}

class LinkDropLoaded extends LinkDropState {
  LinkDropLoaded({required ExtractResponse extractResponse}) 
      : super(extractResponse: extractResponse);
}

class LinkDropExtracting extends LinkDropState{
  final double currentProgress;
  LinkDropExtracting({required this.currentProgress, ExtractResponse? extractResponse}) 
      : super(extractResponse: extractResponse, progress: currentProgress);
}

class LinkDropExtract extends LinkDropState {
  LinkDropExtract() : super();
}

class LinkDropError extends LinkDropState {
  LinkDropError({required String error}) : super(error: error);
}