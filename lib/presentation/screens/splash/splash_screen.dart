import 'package:flutter/material.dart';
import 'package:movie_study_case/config/app_config.dart';
import 'package:movie_study_case/config/theme/app_colors.dart';
import 'package:movie_study_case/core/di/service_locator.dart';
import 'package:movie_study_case/presentation/stores/splash_store/splash_store.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final SplashStore store;
  static const int minDisplayDuration = 2000; // 2 seconds minimum
  late final DateTime startTime;

  @override
  void initState() {
    super.initState();
    startTime = DateTime.now();
    store = getIt<SplashStore>();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await store.preloadData();

    // Preload genre images
    if (mounted) {
      await store.preloadGenreImages(context);
    }

    // Ensure minimum display duration
    final elapsed = DateTime.now().difference(startTime).inMilliseconds;
    final remaining = minDisplayDuration - elapsed;

    if (remaining > 0) {
      await Future.delayed(Duration(milliseconds: remaining));
    }

    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/movie-onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBlack,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/clapperboard.png', width: 170, height: 170),
            const SizedBox(height: 40),
            Text(
              AppConfig.instance.appName,
              style: TextStyle(
                color: AppColors.kWhite,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
