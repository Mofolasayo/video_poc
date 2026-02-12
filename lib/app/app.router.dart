// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i4;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i5;
import 'package:video_poc/ui/views/home/home_view.dart' as _i2;
import 'package:video_poc/ui/views/video_call/video_call_view.dart' as _i3;

class Routes {
  static const homeView = '/home-view';

  static const videoCallView = '/video-call-view';

  static const all = <String>{homeView, videoCallView};
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(Routes.homeView, page: _i2.HomeView),
    _i1.RouteDef(Routes.videoCallView, page: _i3.VideoCallView),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeView: (data) {
      return _i4.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.HomeView(),
        settings: data,
      );
    },
    _i3.VideoCallView: (data) {
      final args = data.getArgs<VideoCallViewArguments>(
        orElse: () => const VideoCallViewArguments(),
      );
      return _i4.MaterialPageRoute<dynamic>(
        builder: (context) => _i3.VideoCallView(
          key: args.key,
          sessionName: args.sessionName,
          userId: args.userId,
        ),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class VideoCallViewArguments {
  const VideoCallViewArguments({this.key, this.sessionName, this.userId});

  final _i4.Key? key;

  final String? sessionName;

  final String? userId;

  @override
  String toString() {
    return '{"key": "$key", "sessionName": "$sessionName", "userId": "$userId"}';
  }

  @override
  bool operator ==(covariant VideoCallViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.sessionName == sessionName &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    return key.hashCode ^ sessionName.hashCode ^ userId.hashCode;
  }
}

extension NavigatorStateExtension on _i5.NavigationService {
  Future<dynamic> navigateToHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  ]) async {
    return navigateTo<dynamic>(
      Routes.homeView,
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToVideoCallView({
    _i4.Key? key,
    String? sessionName,
    String? userId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.videoCallView,
      arguments: VideoCallViewArguments(
        key: key,
        sessionName: sessionName,
        userId: userId,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  ]) async {
    return replaceWith<dynamic>(
      Routes.homeView,
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithVideoCallView({
    _i4.Key? key,
    String? sessionName,
    String? userId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.videoCallView,
      arguments: VideoCallViewArguments(
        key: key,
        sessionName: sessionName,
        userId: userId,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }
}
