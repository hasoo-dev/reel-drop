import 'package:equatable/equatable.dart';

abstract class LibraryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StartDownload extends LibraryEvent {
  final String url;
  final String platform;

  StartDownload({required this.url, required this.platform});

  @override
  List<Object?> get props => [url, platform];
}

class UpdateProgress extends LibraryEvent {
  final double progress;

  UpdateProgress(this.progress);

  @override
  List<Object?> get props => [progress];
}
