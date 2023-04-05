import 'package:flutter/material.dart';

class IssuesCardTheme extends ThemeExtension<IssuesCardTheme> {
  final Color? primaryColor;
  final Color? secondaryColor;
  final TextStyle? titleTextStyle;
  final TextStyle? subtitleTextStyle;

  const IssuesCardTheme({
    this.primaryColor,
    this.secondaryColor,
    this.titleTextStyle,
    this.subtitleTextStyle,
  });

  @override
  IssuesCardTheme copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    TextStyle? titleTextStyle,
    TextStyle? subtitleTextStyle,
  }) {
    return IssuesCardTheme(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
    );
  }

  @override
  IssuesCardTheme lerp(ThemeExtension<IssuesCardTheme>? other, double t) {
    if (other is! IssuesCardTheme) {
      return this;
    }
    return IssuesCardTheme(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t),
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t),
      titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t),
      subtitleTextStyle:
          TextStyle.lerp(subtitleTextStyle, other.subtitleTextStyle, t),
    );
  }
}
