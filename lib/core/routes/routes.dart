import 'package:flutter/material.dart';
import 'package:video_downloder/core/routes/routes_name.dart';
import '../../app/view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
          builder: (BuildContext context) => const SplashView(),
        );

      case RoutesName.home:
        return MaterialPageRoute(
          builder: (BuildContext context) => const HomeView(),
        );
      case RoutesName.info:
        return MaterialPageRoute(
          builder: (BuildContext context) => const InfoView(),
        );
      case RoutesName.noAds:
        return MaterialPageRoute(
          builder: (BuildContext context) => const NoAdsView(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) {
            return const Scaffold(
              body: Center(child: Text('No route defined')),
            );
          },
        );
    }
  }
}
