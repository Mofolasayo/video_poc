import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:video_poc/app/app.locator.dart';
import 'package:video_poc/app/app.router.dart';

class HomeViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  static const String _sessionName = 'video-poc-session';
  String _userId = 'user-a';

  String get sessionName => _sessionName;
  String get userId => _userId;

  void updateUserId(String value) {
    _userId = value.trim().isEmpty ? 'user-a' : value.trim();
    notifyListeners();
  }

  Future<void> startVideoCall() async {
    await _navigationService.navigateToVideoCallView(
      sessionName: _sessionName,
      userId: _userId,
    );
  }
}
