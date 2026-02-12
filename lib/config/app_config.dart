class AppConfig {
  static const String _baseUrl = String.fromEnvironment(
    'VIDEO_POC_API_URL',
    defaultValue: '',
  );
  static const String _renderUrl = 'https://video-poc-backend.onrender.com';

  static String get apiBaseUrl {
    if (_baseUrl.isNotEmpty) {
      return _baseUrl;
    }

    return _renderUrl;
  }
}
