// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_downloder/core/routes/routes_name.dart';
import 'package:video_downloder/services/session_manager/session_controller.dart';

class SplashServices {
  void navigateToWel(BuildContext context) {
    Timer(const Duration(seconds: 4), () async {
      if (context.mounted) {
        final sessionController = SessionController();
        await sessionController.checkFirstRun();

        if (sessionController.isFirstTime) {
          Navigator.pushReplacementNamed(context, RoutesName.welcome);
        } else {
          Navigator.pushReplacementNamed(context, RoutesName.home);
        }
      }
    });
  }
}
