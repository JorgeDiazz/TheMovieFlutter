import 'package:flutter/material.dart';
import 'package:the_movie_db/core/config/theme/app_colors.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
        useMaterial3: false,
        colorSchemeSeed: AppColors.grayManatee,
        brightness: Brightness.light,
      );
}
