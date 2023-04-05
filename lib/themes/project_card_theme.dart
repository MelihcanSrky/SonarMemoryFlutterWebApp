import 'package:flutter/material.dart';

class ProjectCardTheme extends ThemeExtension<ProjectCardTheme> {
  final TextStyle? titleTextStyle;
  final TextStyle? subtitleTextStyle;
  final Color? backgroundColor;
  final Color? dividerColor;

  const ProjectCardTheme({
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.backgroundColor,
    this.dividerColor,
  });

  @override
  ProjectCardTheme copyWith({
    TextStyle? titleTextStyle,
    TextStyle? subtitleTextStyle,
    Color? backgroundColor,
    Color? dividerColor,
  }) {
    return ProjectCardTheme(
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      dividerColor: dividerColor ?? this.dividerColor,
    );
  }

  @override
  ProjectCardTheme lerp(ThemeExtension<ProjectCardTheme>? other, double t) {
    if (other is! ProjectCardTheme) {
      return this;
    }
    return ProjectCardTheme(
      titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t),
      subtitleTextStyle:
          TextStyle.lerp(subtitleTextStyle, other.subtitleTextStyle, t),
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t),
    );
  }
}
