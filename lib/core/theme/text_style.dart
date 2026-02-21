import 'package:flutter/material.dart';

class CosmTextTheme extends ThemeExtension<CosmTextTheme> {
  final Color color;

  late TextStyle _large;
  late TextStyle _medium;
  late TextStyle _small;
  late TextStyle _smallEx;

  CosmTextTheme({required this.color}) {
    _large = TextStyle(
      color: color,
      fontSize: 18,
    );
    _medium = TextStyle(
      color: color,
      fontSize: 16,
    );
    _small = TextStyle(
      color: color,
      fontSize: 14,
    );
    _smallEx = TextStyle(
      color: color,
      fontSize: 12,
    );
  }

  TextStyle get large => _large;

  TextStyle get medium => _medium;

  TextStyle get small => _small;

  TextStyle get smallEx => _smallEx;

  @override
  ThemeExtension<CosmTextTheme> copyWith({Color? color}) {
    if (color == null) {
      return this;
    }
    return CosmTextTheme(color: color);
  }

  @override
  ThemeExtension<CosmTextTheme> lerp(
    covariant ThemeExtension<CosmTextTheme>? other,
    double t,
  ) {
    if (other is! CosmTextTheme) {
      return this;
    }
    return CosmTextTheme(
      color: Color.lerp(color, other.color, t)!,
    );
  }
}
