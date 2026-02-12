import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_poc/ui/common/app_colors.dart';
import 'package:video_poc/ui/common/ui_helpers.dart';

class UpgradeToPro extends StatelessWidget {
  const UpgradeToPro({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 37.sp,
      width: 213.sp,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: k12pxBorderRadius,
        border: Border.all(color: kPrimaryColor, width: 0.5),
      ),
      child: const Text(
        "Upgrade to pro account",
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.italic,
          fontFamily: "Libre",
          color: kPrimaryColor,
        ),
      ),
    );
  }
}
