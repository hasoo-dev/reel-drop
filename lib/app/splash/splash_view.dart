import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:video_downloder/core/componenet/positioned_circle.dart';
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
      body: Stack(
        children: [
          FadeIn(
            delay: Duration(seconds: 1),
            duration: Duration(seconds: 2),

            child: PositionedCircle(),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: ZoomIn(
                  duration: const Duration(seconds: 2),
                  delay: const Duration(seconds: 1),
                  child: Row(
                    mainAxisAlignment: .center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: Image.asset(
                          "assets/icons/ic_reel_drop.png",
                          // height:245,
                          width: 55,
                        ),
                      ),
                      Text('ReelDrop',
                      
                      style: theme.textTheme.displayLarge?.copyWith(
                        color: theme.colorScheme.scrim,
                        letterSpacing: 1.2,
                        
                        
                      ),)
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Center(
              //   child: FadeIn(
              //     duration: const Duration(seconds: 2),
              //     delay: const Duration(seconds: 1),
              //     child: Text(
              //       "Reel Drop",
              //       style: theme.textTheme.headlineLarge?.copyWith(
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //   ),
              // ),
              FadeIn(
                duration: const Duration(seconds: 2),
                delay: const Duration(seconds: 1),
                child: Text(
                  "Fast. Secure. Easy to use.",
                  style: theme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
