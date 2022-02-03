import 'package:dashshomework/colors/colors.dart';
import 'package:dashshomework/typography/typography.dart';
import 'package:flutter/widgets.dart';

/// Defines text styles for the puzzle UI.
class PuzzleTextStyle {
  /// Headline 1 text style
  static TextStyle get headline1 {
    return _baseTextStyle.copyWith(
      fontSize: 74,
      fontWeight: PuzzleFontWeight.regular,
    );
  }

  /// Headline 2 text style
  static TextStyle get headline2 {
    return _baseTextStyle.copyWith(
      fontSize: 54,
      height: 1.1,
      fontWeight: PuzzleFontWeight.regular,
    );
  }

  /// Headline 3 text style
  static TextStyle get headline3 {
    return _baseTextStyle.copyWith(
      fontSize: 34,
      height: 1.12,
      fontWeight: PuzzleFontWeight.regular,
    );
  }

  /// Headline 3 Soft text style
  static TextStyle get headline3Soft {
    return _baseTextStyle.copyWith(
      fontSize: 34,
      height: 1.17,
      fontWeight: PuzzleFontWeight.regular,
    );
  }

  /// Headline 4 text style
  static TextStyle get headline4 {
    return _baseTextStyle.copyWith(
      fontSize: 34,
      height: 1.15,
      fontWeight: PuzzleFontWeight.regular,
    );
  }

  /// Headline 4 Soft text style
  static TextStyle get headline4Soft {
    return _baseTextStyle.copyWith(
      fontSize: 34,
      height: 1.15,
      fontWeight: PuzzleFontWeight.regular,
    );
  }

  /// Headline 5 text style
  static TextStyle get headline5 {
    return _baseTextStyle.copyWith(
      fontSize: 16,
      height: 1.25,
      fontWeight: PuzzleFontWeight.regular,
    );
  }

  /// Body Large regular text style
  static TextStyle get bodyLargeregular {
    return _baseTextStyle.copyWith(
      fontSize: 46,
      height: 1.17,
      fontWeight: PuzzleFontWeight.regular,
    );
  }

  /// Body Large text style
  static TextStyle get bodyLarge {
    return _baseTextStyle.copyWith(
      fontSize: 46,
      height: 1.17,
      fontWeight: PuzzleFontWeight.regular,
    );
  }

  /// Body text style
  static TextStyle get body {
    return _bodyTextStyle.copyWith(
      fontSize: 34,
      height: 1.33,
      fontWeight: PuzzleFontWeight.regular,
    );
  }

  /// Body Small text style
  static TextStyle get bodySmall {
    return _bodyTextStyle.copyWith(
      fontSize: 28,
      height: 1.22,
      fontWeight: PuzzleFontWeight.regular,
    );
  }

  /// Body XSmall text style
  static TextStyle get bodyXSmall {
    return _bodyTextStyle.copyWith(
      fontSize: 14,
      height: 1.27,
      fontWeight: PuzzleFontWeight.regular,
    );
  }

  /// Label text style
  static TextStyle get label {
    return _baseTextStyle.copyWith(
      fontSize: 14,
      height: 1.27,
      fontWeight: PuzzleFontWeight.regular,
    );
  }

  /// Countdown text style
  static TextStyle get countdownTime {
    return _baseTextStyle.copyWith(
      fontSize: 300,
      height: 1,
      fontWeight: PuzzleFontWeight.regular,
    );
  }

  static const _baseTextStyle = TextStyle(
    fontFamily: 'NanumPenScript',
    color: PuzzleColors.black,
    fontWeight: PuzzleFontWeight.regular,
  );

  static const _bodyTextStyle = TextStyle(
    fontFamily: 'NanumPenScript',
    color: PuzzleColors.black,
    fontWeight: PuzzleFontWeight.regular,
  );
}