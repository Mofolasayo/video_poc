import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_videosdk_example/components/intro_image_list.dart';
import 'package:permission_handler/permission_handler.dart';

import '../components/menu_bar.dart';

class JoinArguments {
  final bool isJoin;
  final String sessionName;
  final String sessionPwd;
  final String displayName;
  final String sessionTimeout;
  final String roleType;

  JoinArguments(
      this.isJoin,
      this.sessionName,
      this.sessionPwd,
      this.displayName,
      this.sessionTimeout,
      this.roleType
      );
}

class IntroButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color buttonColor;
  final bool isJoin;

  const IntroButton(
      {super.key,
      required this.text,
      required this.buttonColor,
      required this.textColor,
      required this.isJoin});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
            context, "Join",
            arguments: JoinArguments(
                isJoin,
                "",
                "",
                "",
                "",
                "",
            ))
        ;
      },
      child: Container(
        height: 60.0,
        width: 300.0,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: buttonColor,
            border: Border.all(
              color: Colors.black12,
              width: 1,
            )),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: textColor, fontWeight: FontWeight.normal, fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<StatefulWidget> createState() => IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  // In Android we need to request the storage permission,
  // while in iOS is the photos permission
  Map<String, List<Permission>> platformPermissions = {
    "ios": [
      Permission.camera,
      Permission.microphone,
      //Permission.photos,
    ],
    "android": [
      Permission.camera,
      Permission.microphone,
      Permission.bluetoothConnect,
      Permission.phone,
    ],
  };

  Future<void> requestFilePermission() async {
    if (!Platform.isAndroid && !Platform.isIOS) {}
    bool blocked = false;
    List<Permission>? notGranted = [];
    PermissionStatus result;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    List<Permission>? permissions = [];
    if (Platform.isAndroid) {
      permissions = platformPermissions["android"];
      AndroidDeviceInfo? androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.version.sdkInt <= 31) {
        permissions?.add(Permission.storage);
      }
    } else {
      permissions = platformPermissions["ios"];
    }
    Map<Permission, PermissionStatus>? statuses = await permissions?.request();
    statuses!.forEach((key, status) {
      if (status.isDenied) {
        blocked = true;
      } else if (!status.isGranted) {
        notGranted.add(key);
      }
    });

    if (notGranted.isNotEmpty) {
      notGranted.request();
    }

    if (blocked) {
      await openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Material is a conceptual piece
    // of paper on which the UI appears.
    requestFilePermission();
    return Scaffold(
        key: scaffoldKey,
        body: Stack(
          children: [
            FractionallySizedBox(
              heightFactor: 1,
              child: Container(
                color: Colors.white,
              ),
            ),
            FractionallySizedBox(
              heightFactor: 0.7,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage(
                        "assets/images/intro-bg.png"), // <-- BACKGROUND IMAGE
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  height: 70.0, // in logical pixels
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  // Row is a horizontal, linear layout.
                  child: Row(
                    children: [
                      IconButton(
                        iconSize: 40,
                        icon: const Icon(Icons.menu),
                        tooltip: 'Navigation menu',
                        onPressed: () => scaffoldKey.currentState
                            ?.openDrawer(), // null disables the button
                      ),
                      // Expanded expands its child
                      // to fill the available space.
                    ],
                  ),
                ),
                Stack(
                  children: [
                    const IntroImageList(),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                            margin: const EdgeInsets.only(bottom: 145),
                            child: const Image(
                              image: AssetImage("assets/images/curve-mask.png"),
                            )),
                      ),
                    ),
                    Positioned.fill(
                        child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 150,
                        margin: const EdgeInsets.only(bottom: 0),
                        color: Colors.white,
                      ),
                    ))
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  child: const Center(
                      child: IntroButton(
                    text: "Create",
                    buttonColor: Color(0xff0070f3),
                    textColor: Colors.white,
                    isJoin: false,
                  )),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 60),
                  child: const Center(
                      child: IntroButton(
                          text: "Join",
                          buttonColor: Colors.white,
                          textColor: Color(0xff0070f3),
                          isJoin: true)),
                )
              ],
            ),
          ],
        ),
        drawer: const ZoomMenuBar());
  }
}
