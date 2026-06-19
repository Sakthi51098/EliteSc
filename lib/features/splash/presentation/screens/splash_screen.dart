import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../app/routes/app_route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../services/notifications/push_notification_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  Timer? navigationTimer;

  @override
  void initState() {
    super.initState();
    navigationTimer = Timer(const Duration(seconds: 2), goToNextScreen);
  }

  @override
  void dispose() {
    navigationTimer?.cancel();
    super.dispose();
  }

  Future<void> goToNextScreen() async {
    if (!mounted) {
      return;
    }

    await PushNotificationService.instance.requestPermission();

    if (!mounted) {
      return;
    }

    final currentUser = FirebaseAuth.instance.currentUser;

    Navigator.of(context).pushReplacementNamed(
      currentUser != null ? AppRouteNames.dashboard : AppRouteNames.onboarding,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final iconWidth = size.width * 0.46;
    final logoWidth = size.width * 0.42;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 320),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/app_icon.png',
                    width: iconWidth.clamp(150.0, 210.0),
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 10),
                  Image.asset(
                    'assets/images/app_name.png',
                    width: logoWidth.clamp(135.0, 180.0),
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
