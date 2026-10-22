import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:deen_app/core/widgets/deen_bottom_navigation_bar.dart';
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
        children: const [
          _TabPlaceholder(title: 'Home Screen'),
          _TabPlaceholder(title: 'Community Screen'),
          _TabPlaceholder(title: 'Reflect Screen'),
          _TabPlaceholder(title: 'Prayer Screen'),
          _TabPlaceholder(title: 'Profile Screen'),
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
  const _TabPlaceholder({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text(
          title,
          style: AppTypography.headlineMedium(color: AppColors.textPrimary),
        ),
      ),
    );
  }
}
