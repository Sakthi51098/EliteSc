import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'di/service_locator.dart';
import '../services/firebase/firebase_initializer.dart';
import '../services/notifications/push_notification_service.dart';

void bootstrap(Widget Function() builder) {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      );
      await FirebaseInitializer.initialize();
      await setupDependencies();
      await PushNotificationService.instance.initialize();
      runApp(ProviderScope(child: builder()));
    },
    (error, stackTrace) {
      debugPrint('Bootstrap error: $error');
      debugPrintStack(stackTrace: stackTrace);
    },
  );
}
