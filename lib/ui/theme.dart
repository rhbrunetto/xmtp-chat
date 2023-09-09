import 'package:flutter/material.dart';

import 'colors.dart';

class EthTheme {
  const EthTheme()
      : this._(
          brightness: Brightness.light,
          backgroundColor: EthColors.mimiPink,
          primaryTextColor: EthColors.chinaRose,
          secondaryTextColor: EthColors.cherryPink,
          dividerColor: EthColors.lavender,
          highlightColor: EthColors.violetBlue,
        );

  const EthTheme._({
    required this.backgroundColor,
    required this.primaryTextColor,
    required this.secondaryTextColor,
    required this.brightness,
    required this.dividerColor,
    required this.highlightColor,
  });

  final Color backgroundColor;
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final Brightness brightness;
  final Color dividerColor;
  final Color highlightColor;

  TextStyle get _baseTextStyle => const TextStyle(
        height: 1.25,
        color: EthColors.violetBlue,
      );

  ButtonStyle get _buttonStyle => ButtonStyle(
        animationDuration: Duration.zero,
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
        backgroundColor: MaterialStateProperty.all(EthColors.violetBlue),
        foregroundColor: MaterialStateProperty.all(EthColors.mimiPink),
        iconColor: MaterialStateProperty.all(EthColors.mimiPink),
      );

  ThemeData toMaterialTheme() => ThemeData(
        brightness: brightness,
        splashColor: Colors.transparent,
        textButtonTheme: TextButtonThemeData(style: _buttonStyle),
        textTheme: TextTheme(
          displayLarge: _baseTextStyle.copyWith(
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: _baseTextStyle.copyWith(
            fontSize: 42,
            fontWeight: FontWeight.w600,
          ),
          displaySmall: _baseTextStyle.copyWith(
            fontSize: 26,
            fontWeight: FontWeight.w700,
          ),
          headlineMedium: _baseTextStyle.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          titleMedium: _baseTextStyle.copyWith(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          titleSmall: _baseTextStyle.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          bodyLarge: _baseTextStyle.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
          bodyMedium: _baseTextStyle.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          bodySmall: _baseTextStyle.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
          labelLarge: _baseTextStyle.copyWith(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        colorScheme: ColorScheme.light(
          brightness: brightness,
          primary: EthColors.lavender,
          secondary: EthColors.violetBlue,
          background: backgroundColor,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: EthColors.violetBlue,
          titleTextStyle: _baseTextStyle.copyWith(
            fontSize: 17,
            color: EthColors.mimiPink,
            fontWeight: FontWeight.bold,
            letterSpacing: .23,
          ),
          foregroundColor: EthColors.mimiPink,
        ),
        canvasColor: backgroundColor,
        scaffoldBackgroundColor: backgroundColor,
        highlightColor: EthColors.violetBlue,
        hintColor: EthColors.chinaRose,
        dividerColor: EthColors.violetBlue,
      );
}
