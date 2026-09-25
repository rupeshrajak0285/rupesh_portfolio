import 'package:flutter/material.dart';

import '../../core/utils/responsive.dart';

/// Constrains section content to the page width and applies vertical rhythm.
class SectionContainer extends StatelessWidget {
  const SectionContainer({
    super.key,
    required this.child,
    this.sectionKey,
    this.verticalPadding,
    this.background,
  });
  final Widget child;
  final Key? sectionKey;
  final double? verticalPadding;
  final Widget? background;

  @override
  Widget build(BuildContext context) {
    final double pad = verticalPadding ?? Responsive.value<double>(context, mobile: 72, desktop: 120);
    return Stack(
      key: sectionKey,
      children: [
        if (background != null) Positioned.fill(child: background!),
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: Responsive.maxContentWidth),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.horizontalPadding(context),
                vertical: pad,
              ),
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}
