import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_downloder/bloc/library_bloc/library_bloc.dart';
import 'package:video_downloder/repository/library_repository/library_repository.dart';
import 'package:video_downloder/core/routes/routes.dart';
import 'package:video_downloder/core/routes/routes_name.dart';
import 'package:video_downloder/core/theme/app_theme.dart';

class ReelDrop extends StatelessWidget {
  const ReelDrop({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [RepositoryProvider(create: (context) => LibraryRepository())],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LibraryBloc(
              libraryRepository: context.read<LibraryRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          title: "Reel Drop",
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          initialRoute: RoutesName.splash,
          onGenerateRoute: Routes.generateRoute,
        ),
      ),
    );
  }
}
