import 'package:flutter/material.dart';
import 'package:movie_study_case/config/app_config.dart';
import 'package:movie_study_case/main.dart' as entry_point;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppConfig.init(
    appName: 'Movie App',
    apiBaseUrl: 'https://api.themoviedb.org/3',
    flavor: Environment.prod,
  );

  entry_point.main();
}
