import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_downloder/bloc/reel_bloc/reel_drop_bloc.dart';
import 'package:video_downloder/core/routes/routes.dart';
import 'package:video_downloder/core/routes/routes_name.dart';
import 'package:video_downloder/core/theme/app_theme.dart';
import 'package:video_downloder/core/theme/theme_controller.dart';
import 'package:video_downloder/repository/reel_drop_api/reel_drop_api_repositry.dart';
import 'package:video_downloder/repository/reel_drop_api/reel_drop_repositry.dart';

class ReelDrop extends StatelessWidget {
  const ReelDrop({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ReelDropApiRepositry>(
          create: (context) => ReelDropApiRepositryImpl(),
        ),
      ],
      child: BlocProvider(
        create: (context) => ReelDropBloc(context.read<ReelDropApiRepositry>()),
        child: ValueListenableBuilder<ThemeMode>(
          valueListenable: ThemeController.themeMode,
          builder: (context, mode, _) {
            return MaterialApp(
              title: "Reel Drop",
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: mode,
              initialRoute: RoutesName.splash,
              onGenerateRoute: Routes.generateRoute,
            );
          },
        ),
      ),
    );
  }
}
