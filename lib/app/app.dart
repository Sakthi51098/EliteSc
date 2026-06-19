import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../features/splash/presentation/screens/splash_screen.dart';
import 'routes/app_routes.dart';
import 'theme/app_theme.dart';

class EliteApp extends StatelessWidget {
  const EliteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elite',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      builder: (context, child) {
        final mediaQuery = MediaQuery.of(context);

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
          child: MediaQuery(
            data: mediaQuery.copyWith(textScaler: const TextScaler.linear(1)),
            child: child ?? const SizedBox(),
          ),
        );
      },
      onGenerateRoute: AppRoutes.onGenerateRoute,
      home: const SplashScreen(),
    );
  }
}
