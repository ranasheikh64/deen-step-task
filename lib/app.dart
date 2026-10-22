import 'package:deen_app/core/routing/app_router.dart';
import 'package:deen_app/core/routing/app_routes.dart';
import 'package:deen_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Root widget of the application
class DeenApp extends StatefulWidget {
  const DeenApp({super.key, this.initialRoute = AppRoutes.onboarding});

  final String initialRoute;

  @override
  State<DeenApp> createState() => _DeenAppState();
}

class _DeenAppState extends State<DeenApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = AppRouter.createRouter(widget.initialRoute);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Deen',
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
