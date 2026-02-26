import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:video_downloder/services/splash_services/splash_services.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    SplashServices().navigateToWel(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: ZoomIn(
        delay: const Duration(seconds: 1),
        duration: const Duration(seconds: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ZoomIn(
                duration: const Duration(seconds: 2),
                delay: const Duration(seconds: 1),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Image.asset(
                    "assets/icons/ic_library.png",
                    height: 200,
                    width: 100,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                "Reel Drop",
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Text(
                "Collect, Manage content links",
                style: theme.textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
