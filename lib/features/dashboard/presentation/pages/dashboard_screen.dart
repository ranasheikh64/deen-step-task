import 'package:deen_app/core/di/service_locator.dart';
import 'package:deen_app/core/services/storage/secure_storage_service.dart';
import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:deen_app/core/widgets/deen_bottom_navigation_bar.dart';
import 'package:deen_app/core/widgets/deen_button.dart';
import 'package:deen_app/features/home/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';

/// Main Dashboard Screen containing the persistent [DeenBottomNavigationBar]
/// and 5 tab views (Home, Community, Reflect, Prayer, Profile).
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _onTabSelected(int index) {
    if (_currentIndex == index) return;
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: _currentIndex,
        children: [
          const HomeScreen(),
          const _TabPlaceholder(title: 'Community Screen'),
          const _TabPlaceholder(title: 'Reflect Screen'),
          const _TabPlaceholder(title: 'Prayer Screen'),
          _TabPlaceholder(
            title: 'Profile Screen',
            onTap: () async {
              await sl<SecureStorageService>().logout(context);
            },
            hasLogoutButton: true,
          ),
        ],
      ),
      bottomNavigationBar: DeenBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabSelected,
      ),
    );
  }
}

class _TabPlaceholder extends StatelessWidget {
  const _TabPlaceholder({
    required this.title,
    this.onTap,
    this.hasLogoutButton = false,
  });

  final String title;
  final VoidCallback? onTap;
  final bool hasLogoutButton;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: AppTypography.headlineMedium(color: AppColors.textPrimary),
            ),
            const SizedBox(height: 16),
            if (hasLogoutButton)
              Padding(
                padding: const EdgeInsets.all(8),
                child: DeenButton(onPressed: onTap, text: 'Logout'),
              )
            else
              const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
