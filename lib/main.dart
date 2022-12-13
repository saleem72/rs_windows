import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rs_windows/helpers/app_theme/app_theme.dart';

import 'dependancy_injection.dart' as di;
import 'helpers/app_theme/app_theme_cubit/app_theme_cubit.dart';
import 'helpers/auth_manager/auth_cubit/auth_cubit.dart';
import 'helpers/localization/locale_cubit/locale_cubit.dart';
import 'screens/landing_screen/landing_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocaleCubit(safe: di.locator())),
        BlocProvider(create: (context) => AppThemeCubit(safe: di.locator())),
        BlocProvider(create: (context) => AuthCubit(safe: di.locator())),
      ],
      child: const RestListApp(),
    );
  }
}

class RestListApp extends StatelessWidget {
  const RestListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en', ''),
      home: const LandingScreen(),
    );
  }
}
