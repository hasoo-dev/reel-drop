class DownloadResponse {
  bool? success;
  Data? data;

  DownloadResponse({this.success, this.data});

  DownloadResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? title;
  String? thumbnail;
  double? duration;
  String? uploader;
  String? url;
  List<Formats>? formats;

  Data(
      {this.title,
      this.thumbnail,
      this.duration,
      this.uploader,
      this.url,
      this.formats});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title']?.toString();
    thumbnail = json['thumbnail']?.toString();
    duration = json['duration']?.toDouble();
    uploader = json['uploader']?.toString();
    url = json['url']?.toString();
    if (json['formats'] != null) {
      formats = <Formats>[];
      json['formats'].forEach((v) {
        formats!.add(new Formats.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['thumbnail'] = this.thumbnail;
    data['duration'] = this.duration;
    data['uploader'] = this.uploader;
    data['url'] = this.url;
    if (this.formats != null) {
      data['formats'] = this.formats!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Formats {
  String? formatId;
  String? ext;
  String? quality;
  int? width;
  int? height;
  int? filesize;
  String? url;
  String? vcodec;
  String? acodec;
  bool? hasAudio;

  Formats(
      {this.formatId,
      this.ext,
      this.quality,
      this.width,
      this.height,
      this.filesize,
      this.url,
      this.vcodec,
      this.acodec,
      this.hasAudio});

  Formats.fromJson(Map<String, dynamic> json) {
    formatId = json['format_id']?.toString();
    ext = json['ext']?.toString();
    quality = json['quality']?.toString();
    width = json['width']?.toInt();
    height = json['height']?.toInt();
    filesize = json['filesize']?.toInt();
    url = json['url']?.toString();
    vcodec = json['vcodec']?.toString();
    acodec = json['acodec']?.toString();
    hasAudio = json['has_audio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['format_id'] = this.formatId;
    data['ext'] = this.ext;
    data['quality'] = this.quality;
    data['width'] = this.width;
    data['height'] = this.height;
    data['filesize'] = this.filesize;
    data['url'] = this.url;
    data['vcodec'] = this.vcodec;
    data['acodec'] = this.acodec;
    data['has_audio'] = this.hasAudio;
    return data;
  }
}