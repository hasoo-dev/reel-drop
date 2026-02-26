import 'package:video_downloder/services/storage/local_storage.dart';

class SessionController {
  static final SessionController _instance = SessionController._internal();

  factory SessionController() {
    return _instance;
  }

  SessionController._internal();

  final LocalStorage _localStorage = LocalStorage();
  bool? _isFirstTime;

  bool get isFirstTime => _isFirstTime ?? true;

  Future<void> checkFirstRun() async {
    final value = await _localStorage.readValue('isFirstTime');
    if (value == null) {
      _isFirstTime = true;
    } else {
      _isFirstTime = value == 'false' ? false : true;
    }
  }

  Future<void> setFirstRunComplete() async {
    await _localStorage.setValue('isFirstTime', 'false');
    _isFirstTime = false;
  }
}
