import 'package:flutter/cupertino.dart';
import 'package:video_poc/ui/common/app_colors.dart';

class CustomProgressIndicator extends StatelessWidget {
  final Color? color;
  final double? radius;
  final double? value;

  const CustomProgressIndicator({Key? key, this.color, this.radius, this.value})
    : super(key: key);

  Color get _color => color ?? kPrimaryColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(color: _color, radius: radius ?? 15),
    );
  }
}
