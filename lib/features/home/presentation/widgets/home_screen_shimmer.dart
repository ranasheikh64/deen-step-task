import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/widgets/deen_shimmer.dart';
import 'package:flutter/material.dart';

/// Shimmer skeleton loader for HomeScreen during initial and reload state
class HomeScreenShimmer extends StatelessWidget {
  const HomeScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 360 + topPadding,
              decoration: const BoxDecoration(
                color: AppColors.homeHeaderBackground,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(AppSpacing.radiusXxl),
                ),
              ),
              padding: EdgeInsets.fromLTRB(
                AppSpacing.lg,
                topPadding + AppSpacing.xs,
                AppSpacing.lg,
                AppSpacing.sm,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: DeenShimmer(width: 170, height: 28, borderRadius: 14),
                  ),
                  SizedBox(height: AppSpacing.md),
                  DeenShimmer(width: 140, height: 16, borderRadius: 4),
                  SizedBox(height: AppSpacing.sm),
                  DeenShimmer(width: 220, height: 48, borderRadius: 8),
                  SizedBox(height: AppSpacing.sm),
                  DeenShimmer(width: 150, height: 26, borderRadius: 13),
                  Spacer(),
                  DeenShimmer(width: double.infinity, height: 75, borderRadius: 12),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Column(
                children: [
                  SizedBox(height: AppSpacing.md),
                  DeenShimmer(
                    width: double.infinity,
                    height: 68,
                    borderRadius: AppSpacing.radiusLg,
                  ),
                  SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      Expanded(
                        child: DeenShimmer(
                          height: 120,
                          borderRadius: AppSpacing.radiusLg,
                        ),
                      ),
                      SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: DeenShimmer(
                          height: 120,
                          borderRadius: AppSpacing.radiusLg,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSpacing.md),
                  DeenShimmer(
                    width: double.infinity,
                    height: 90,
                    borderRadius: AppSpacing.radiusLg,
                  ),
                  SizedBox(height: AppSpacing.md),
                  DeenShimmer(
                    width: double.infinity,
                    height: 150,
                    borderRadius: AppSpacing.radiusLg,
                  ),
                  SizedBox(height: AppSpacing.xxxl),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
