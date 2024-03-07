import 'package:flutter/material.dart';

class NovinarkoColorsExtension extends ThemeExtension<NovinarkoColorsExtension> {
  final Color background;
  final Color text;
  final Color primary;

  NovinarkoColorsExtension({
    required this.background,
    required this.text,
    required this.primary,
  });

  @override
  ThemeExtension<NovinarkoColorsExtension> copyWith({
    Color? white,
    Color? background,
    Color? text,
    Color? primary,
  }) =>
      NovinarkoColorsExtension(
        background: background ?? this.background,
        text: text ?? this.text,
        primary: primary ?? this.primary,
      );

  @override
  ThemeExtension<NovinarkoColorsExtension> lerp(
    covariant ThemeExtension<NovinarkoColorsExtension>? other,
    double t,
  ) {
    if (other is! NovinarkoColorsExtension) {
      return this;
    }

    return NovinarkoColorsExtension(
      background: Color.lerp(background, other.background, t)!,
      text: Color.lerp(text, other.text, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
    );
  }
}
