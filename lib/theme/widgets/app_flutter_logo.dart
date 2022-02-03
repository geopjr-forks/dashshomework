import 'package:dashshomework/theme/themes/themes.dart';
import 'package:flutter/material.dart';

/// {@template app_flutter_logo}
/// Variant of Flutter logo that can be either white or colored.
/// {@endtemplate}
class AppFlutterLogo extends StatelessWidget {
  /// {@macro app_flutter_logo}
  const AppFlutterLogo({
    Key? key,
    this.height,
  }) : super(key: key);

  /// The optional height of this logo.
  final double? height;

  @override
  Widget build(BuildContext context) {
    const title = "Dash's Homework";
    const text = Text(
      title,
      style: TextStyle(
        fontFamily: 'NanumPenScript',
        color: Color(0xFFFF0000),
        fontSize: 40,
        // backgroundColor: Colors.white,
      ),
    );

    return const AnimatedSwitcher(
      duration: PuzzleThemeAnimationDuration.logoChange,
      child: text,
    );
  }
}
