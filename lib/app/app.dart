import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:video_poc/services/zoom_token_service.dart';
import 'package:video_poc/services/zoom_video_service.dart';
import 'package:video_poc/ui/views/home/home_view.dart';
import 'package:video_poc/ui/views/video_call/video_call_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: VideoCallView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: ZoomVideoService),
    LazySingleton(classType: ZoomTokenService),
  ],
)
class App {}
