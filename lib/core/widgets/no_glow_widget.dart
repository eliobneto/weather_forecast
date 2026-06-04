import 'package:flutter/material.dart';

class NoGlowWidget extends StatelessWidget {
  const NoGlowWidget({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) =>
      NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return false;
        },
        child: child ?? const SizedBox.shrink(),
      );
}
