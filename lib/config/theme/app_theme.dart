import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      fontFamily: GoogleFonts.inter().fontFamily,
      primaryColor: AppColors.kLightRed,
      primaryColorDark: AppColors.kDarkRed,
      scaffoldBackgroundColor: AppColors.kBlack,
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
    );
  }
}
