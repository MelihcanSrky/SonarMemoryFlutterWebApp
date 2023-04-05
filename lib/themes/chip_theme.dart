import 'package:flutter/material.dart';

class BranchChipTheme extends ThemeExtension<BranchChipTheme> {
  final Color? primaryColor;
  final Color? secondaryColor;
  final TextStyle? textStyle;

  const BranchChipTheme({
    this.primaryColor,
    this.secondaryColor,
    this.textStyle,
  });

  @override
  BranchChipTheme copyWith({
    Color? backgroundColor,
    Color? secondaryColor,
    TextStyle? textStyle,
  }) {
    return BranchChipTheme(
      primaryColor: backgroundColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  @override
  BranchChipTheme lerp(ThemeExtension<BranchChipTheme>? other, double t) {
    if (other is! BranchChipTheme) {
      return this;
    }
    return BranchChipTheme(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t),
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t),
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t),
    );
  }
}
