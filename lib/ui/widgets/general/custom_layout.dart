import 'package:flutter/material.dart';

class PaddedColumn extends StatelessWidget {
  final EdgeInsets? padding;
  final List<Widget>? children;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisSize? mainAxisSize;
  final bool? visible;

  const PaddedColumn({
    this.children,
    super.key,
    this.padding,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.mainAxisSize,
    this.visible,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible ?? true,
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Column(
          mainAxisSize: mainAxisSize ?? MainAxisSize.min,
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
          crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
          children: children ?? [],
        ),
      ),
    );
  }
}

class PaddedRow extends StatelessWidget {
  final List<Widget>? children;
  final EdgeInsets? padding;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;
  final MainAxisSize? mainAxisSize;
  final bool? visible;

  const PaddedRow({
    this.children,
    super.key,
    this.padding,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
    this.mainAxisSize,
    this.visible,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible ?? true,
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Row(
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
          mainAxisSize: mainAxisSize ?? MainAxisSize.max,
          crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
          children: children ?? [],
        ),
      ),
    );
  }
}

class ScrollableColumn extends StatelessWidget {
  final List<Widget>? children;
  final EdgeInsets? padding;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;
  final ScrollController? scrollController;

  const ScrollableColumn({
    super.key,
    this.children,
    this.padding,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      padding: padding,
      child: Column(
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
        children: children ?? [],
      ),
    );
  }
}
