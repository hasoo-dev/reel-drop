class AppUrl {
  static var baseUrl = 'http://192.168.18.4:3000';
  static var health = '$baseUrl/api/video/health';
  static var platform = '$baseUrl/api/video/platforms';
  static var info = '$baseUrl/api/video/info';
  static var download = '$baseUrl/api/video/download';
  static var proxy = '$baseUrl/api/video/proxy?url=';
}