import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:video_poc/app/app.locator.dart';
import 'package:video_poc/app/app.router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const VideoPocApp());
}

class VideoPocApp extends StatelessWidget {
  const VideoPocApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      builder: (context, child) => MaterialApp(
        title: 'Video POC',
        debugShowCheckedModeBanner: false,
        navigatorKey: StackedService.navigatorKey,
        initialRoute: Routes.homeView,
        onGenerateRoute: StackedRouter().onGenerateRoute,
        navigatorObservers: [StackedService.routeObserver],
      ),
    );
  }
}
