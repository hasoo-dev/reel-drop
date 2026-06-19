import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/link_bloc/link_drop_bloc.dart';
import 'core/routes/routes.dart';
import 'core/routes/routes_name.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller.dart';
import 'repository/link_drop_api/link_drop_api_repositry.dart';
import 'repository/link_drop_api/link_drop_repositry.dart';
 

class  LinkDrop extends StatelessWidget {
  const  LinkDrop({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<LinkDropApiRepositry>(
          create: (context) => LinkDropApiRepositryImpl(),
        ),
      ],
      child: BlocProvider(
        create: (context) => LinkDropBloc(context.read<LinkDropApiRepositry>()),
        child: ValueListenableBuilder<ThemeMode>(
          valueListenable: ThemeController.themeMode,
          builder: (context, mode, _) {
            return MaterialApp(
              title: "LinkDrop",
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
