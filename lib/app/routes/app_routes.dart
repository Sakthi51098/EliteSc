import 'package:flutter/material.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/models/register_screen_args.dart';
import '../../features/auth/presentation/models/otp_verification_screen_args.dart';
import '../../features/auth/presentation/screens/congratulations_screen.dart';
import '../../features/auth/presentation/screens/otp_verification_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/game/presentation/models/game_details_screen_args.dart';
import '../../features/game/presentation/screens/game_details_screen.dart';
import '../../features/game/presentation/screens/game_webview_screen.dart';
import '../../features/game/presentation/screens/rummy_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import 'app_route_names.dart';

class AppRoutes {
  AppRoutes._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteNames.splash:
        return MaterialPageRoute<void>(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );
      case AppRouteNames.onboarding:
        return MaterialPageRoute<void>(
          builder: (_) => const OnboardingScreen(),
          settings: settings,
        );
      case AppRouteNames.login:
        return MaterialPageRoute<void>(
          builder: (_) => const LoginScreen(),
          settings: settings,
        );
      case AppRouteNames.register:
        final args = settings.arguments as RegisterScreenArgs?;
        return MaterialPageRoute<void>(
          builder: (_) => RegisterScreen(args: args),
          settings: settings,
        );
      case AppRouteNames.congratulations:
        return MaterialPageRoute<void>(
          builder: (_) => const CongratulationsScreen(),
          settings: settings,
        );
      case AppRouteNames.otpVerification:
        final args = settings.arguments as OtpVerificationScreenArgs?;
        return MaterialPageRoute<void>(
          builder: (_) => OtpVerificationScreen(args: args),
          settings: settings,
        );
      case AppRouteNames.dashboard:
        return MaterialPageRoute<void>(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );
      case AppRouteNames.rummy:
        return MaterialPageRoute<void>(
          builder: (_) => const RummyScreen(),
          settings: settings,
        );
      case AppRouteNames.gameDetails:
        final args = settings.arguments as GameDetailsScreenArgs;
        return MaterialPageRoute<void>(
          builder: (_) => GameDetailsScreen(args: args),
          settings: settings,
        );
      case AppRouteNames.gameWebView:
        final args = settings.arguments as GameWebViewScreenArgs;
        return MaterialPageRoute<void>(
          builder: (_) => GameWebViewScreen(args: args),
          settings: settings,
        );
      default:
        return MaterialPageRoute<void>(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );
    }
  }
}
