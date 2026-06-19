class LinkDropEvent {
  final String url;
  LinkDropEvent({required this.url});
}

class FetchVideoData extends LinkDropEvent {
  FetchVideoData({required super.url});
}

class ExtrackingVideo extends LinkDropEvent  {
  final String videoUrl;
  final String title;
  final String ext;
  final String? uploader;

  ExtrackingVideo({
    required super.url,
    required this.videoUrl,
    required this.title,
    required this.ext,
    this.uploader,
  });
}