import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:weather_forecast/core/definitions/context.dart';
import 'package:weather_forecast/core/definitions/palette.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
    this.hasLeading = true,
    this.leading,
    required this.title,
    this.actions,
    this.backgroundColor = Palette.primary,
    this.iconColor = Palette.white,
  });

  final bool hasLeading;
  final Widget? leading;
  final String title;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? iconColor;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) => AppBar(
    iconTheme: IconThemeData(color: iconColor),
    leading: const SizedBox.shrink(),
    title: AutoSizeText(
      title,
      style: context.textTheme.headlineMedium?.copyWith(
        color: iconColor,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
      maxLines: 1,
    ),
    centerTitle: true,
    actions: actions,
    backgroundColor: backgroundColor,
    elevation: 0.0,
  );
}
