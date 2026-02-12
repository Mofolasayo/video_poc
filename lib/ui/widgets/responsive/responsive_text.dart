import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_poc/ui/common/app_colors.dart';

class ResponsiveText extends StatelessWidget {
  final String data;
  final num? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final bool? softWrap;
  final TextOverflow? overflow;
  final GestureTapCallback? onTap;
  final TextDecoration? decoration;

  const ResponsiveText(
    this.data, {
    super.key,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.softWrap,
    this.overflow,
    this.onTap,
    this.decoration,
  });

  const ResponsiveText.w300(
    this.data, {
    super.key,
    this.fontSize,
    this.color,
    this.fontWeight = FontWeight.w300,
    this.textAlign,
    this.maxLines,
    this.softWrap,
    this.overflow,
    this.onTap,
    this.decoration,
  });

  const ResponsiveText.w400(
    this.data, {
    super.key,
    this.fontSize,
    this.color,
    this.fontWeight = FontWeight.w400,
    this.textAlign,
    this.maxLines,
    this.softWrap,
    this.overflow,
    this.onTap,
    this.decoration,
  });

  const ResponsiveText.w500(
    this.data, {
    super.key,
    this.fontSize,
    this.color,
    this.fontWeight = FontWeight.w500,
    this.textAlign,
    this.maxLines,
    this.softWrap,
    this.overflow,
    this.onTap,
    this.decoration,
  });

  const ResponsiveText.w600(
    this.data, {
    super.key,
    this.fontSize,
    this.color,
    this.fontWeight = FontWeight.w600,
    this.textAlign,
    this.maxLines,
    this.softWrap,
    this.overflow,
    this.onTap,
    this.decoration,
  });

  const ResponsiveText.w700(
    this.data, {
    super.key,
    this.fontSize,
    this.color,
    this.fontWeight = FontWeight.w700,
    this.textAlign,
    this.maxLines,
    this.softWrap,
    this.overflow,
    this.onTap,
    this.decoration,
  });
  const ResponsiveText.w800(
    this.data, {
    super.key,
    this.fontSize,
    this.color,
    this.fontWeight = FontWeight.w700,
    this.textAlign,
    this.maxLines,
    this.softWrap,
    this.overflow,
    this.onTap,
    this.decoration,
  });
  const ResponsiveText.w900(
    this.data, {
    super.key,
    this.fontSize,
    this.color,
    this.fontWeight = FontWeight.w700,
    this.textAlign,
    this.maxLines,
    this.softWrap,
    this.overflow,
    this.onTap,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        data,
        textAlign: textAlign,
        maxLines: maxLines,
        softWrap: softWrap,
        overflow: overflow,
        style: TextStyle(
          decoration: decoration,
          fontFamily: 'Geist',
          fontWeight: fontWeight ?? FontWeight.w500,
          fontSize: (fontSize ?? 14).sp,
          color: color ?? kTextColor,
          letterSpacing: -0.64,
        ),
      ),
    );
  }
}
