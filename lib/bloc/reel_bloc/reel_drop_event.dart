class ReelDropEvent {
  final String url;
  ReelDropEvent({required this.url});
}

class FetchVideoData extends ReelDropEvent {
  FetchVideoData({required super.url});
}

class DownloadVideo extends ReelDropEvent {
  final String videoUrl;
  final String title;
  final String ext;
  
  DownloadVideo({
    required super.url,
    required this.videoUrl,
    required this.title,
    required this.ext,
  });
}