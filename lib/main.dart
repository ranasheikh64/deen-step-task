import 'package:deen_app/app.dart';
import 'package:deen_app/core/di/service_locator.dart';
import 'package:deen_app/core/services/auth/auth_session_manager.dart';
import 'package:deen_app/core/services/notifications/push_notification_service.dart';
import 'package:deen_app/core/utils/app_bloc_observer.dart';
import 'package:deen_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

export 'package:deen_app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } on Object catch (e) {
    debugPrint('⚠️ [Firebase] Initialization error: $e');
  }

  await initServiceLocator();
  try {
    await sl<PushNotificationService>().initialize();
  } on Object catch (e) {
    debugPrint('⚠️ [Notification] Service init error: $e');
  }

  final initialRoute = await sl<AuthSessionManager>().determineInitialRoute();
  runApp(DeenApp(initialRoute: initialRoute));
}
