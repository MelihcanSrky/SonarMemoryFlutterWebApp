import 'package:flutter/material.dart';
import 'package:flutter_sonar_app/dashboard/utils/dimens.dart';
import 'package:flutter_sonar_app/themes/chip_theme.dart';
import 'package:flutter_sonar_app/themes/issues_card_theme.dart';
import 'package:flutter_sonar_app/themes/project_card_theme.dart';

import '../dashboard/utils/CustomColors.dart';

Map<String, ThemeData> themes = {
  'light': ThemeData(
    extensions: const <ThemeExtension<dynamic>>[
      ProjectCardTheme(
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        subtitleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        backgroundColor: Colors.white,
        dividerColor: CustomColors.dividerColor,
      ),
      IssuesCardTheme(
        primaryColor: CustomColors.primaryBlue,
        secondaryColor: CustomColors.secondaryBlue,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: Dimens.Title2,
          fontWeight: FontWeight.w600,
        ),
        subtitleTextStyle: TextStyle(
          color: CustomColors.lightSubTextColor,
          fontSize: Dimens.Title3,
          fontWeight: FontWeight.bold,
        ),
      ),
      BranchChipTheme(
        primaryColor: CustomColors.primaryBlue,
        secondaryColor: CustomColors.secondaryBlue,
        textStyle: TextStyle(
          color: CustomColors.lightSubTextColor,
          fontSize: Dimens.Title2,
          fontWeight: FontWeight.w500,
        ),
      )
    ],
    scaffoldBackgroundColor: CustomColors.lightBackground,
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all<TextStyle>(
          TextStyle(
            color: CustomColors.primaryBlue,
            fontSize: Dimens.Title2,
            fontWeight: FontWeight.w500,
          ),
        ),
        foregroundColor:
            MaterialStateProperty.all<Color>(CustomColors.primaryBlue),
        overlayColor:
            MaterialStateProperty.all<Color>(CustomColors.secondaryBlue),
      ),
    ),
  ),
  'dark': ThemeData(extensions: const <ThemeExtension<dynamic>>[
    ProjectCardTheme(
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      subtitleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      backgroundColor: CustomColors.secondaryPurple,
      dividerColor: Colors.white,
    ),
    IssuesCardTheme(
      primaryColor: CustomColors.darkPrimaryBlue,
      secondaryColor: CustomColors.drawerColor,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: Dimens.Title2,
        fontWeight: FontWeight.w600,
      ),
      subtitleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: Dimens.Title3,
        fontWeight: FontWeight.bold,
      ),
    ),
    BranchChipTheme(
      primaryColor: CustomColors.primaryBlue,
      secondaryColor: CustomColors.secondaryBlue,
      textStyle: TextStyle(
        color: Colors.white,
        fontSize: Dimens.Title2,
        fontWeight: FontWeight.w500,
      ),
    )
  ], scaffoldBackgroundColor: CustomColors.darkBackground),
};
