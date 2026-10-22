import 'package:deen_app/core/di/service_locator.dart';
import 'package:deen_app/core/routing/app_router.dart';
import 'package:deen_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServiceLocator();
  runApp(const DeenApp());
}

/// Root widget of the application
class DeenApp extends StatelessWidget {
  const DeenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Deen',
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
