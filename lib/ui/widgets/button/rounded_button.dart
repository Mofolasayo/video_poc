import 'package:flutter/material.dart';
import 'package:video_poc/ui/common/app_colors.dart';
import 'package:video_poc/ui/common/ui_helpers.dart';
import 'package:video_poc/ui/widgets/general/progress_indicator.dart';

class RoundedButton extends StatelessWidget {
  final String? text;
  final Widget? leading;
  final Widget? trailing;

  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final Color? color;
  final Color? textColor;
  final Color? indicatorColor;
  final bool isLoading;
  final bool activated;
  final BorderRadiusGeometry? borderRadius;
  final double? elevation;

  const RoundedButton({
    this.onPressed,
    this.leading,
    this.text,
    this.width,
    this.height,
    this.color,
    this.textColor,
    this.indicatorColor,
    this.isLoading = false,
    this.activated = true,
    Key? key,
    this.borderRadius,
    this.elevation,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: elevation,
      onPressed: activated ? onPressed : null,
      minWidth: width ?? double.infinity,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(99),
      ),
      height: height ?? 42,
      color: color ?? kPrimaryColor,
      disabledColor: color ?? kEAEAEA,
      disabledTextColor: textColor ?? k8C8C8C,
      child: isLoading
          ? CustomProgressIndicator(color: indicatorColor ?? Colors.white)
          : Center(
              child: Row(
                mainAxisAlignment: leading == null || trailing == null
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: [
                  Visibility(
                    visible: leading != null,
                    child: Row(
                      children: [
                        horizontalSpaceTiny,
                        leading ?? const SizedBox.shrink(),
                        horizontalSpaceTiny,
                      ],
                    ),
                  ),
                  Text(
                    text ?? '',
                    style: kGeistMedium15Responsive().copyWith(
                      color:
                          textColor ??
                          (activated && onPressed != null
                              ? Colors.white
                              : k8C8C8C),
                    ),
                  ),
                  Visibility(
                    visible: trailing != null,
                    child: Row(
                      children: [
                        horizontalSpaceTiny,
                        trailing ?? const SizedBox.shrink(),
                        horizontalSpaceTiny,
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
