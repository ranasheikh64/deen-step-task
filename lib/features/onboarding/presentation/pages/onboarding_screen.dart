import 'package:deen_app/core/routing/app_routes.dart';
import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:deen_app/core/widgets/deen_button.dart';
import 'package:deen_app/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:deen_app/features/onboarding/presentation/bloc/onboarding_event.dart';
import 'package:deen_app/features/onboarding/presentation/bloc/onboarding_state.dart';
import 'package:deen_app/features/onboarding/presentation/widgets/onboarding_content_widget.dart';
import 'package:deen_app/features/onboarding/presentation/widgets/onboarding_star_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

/// Stateless Onboarding Screen powered by [OnboardingBloc].
/// Implements 4-screen flow matching Figma nodes 1:927 and 1:997.
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingBloc(),
      child: const _OnboardingView(),
    );
  }
}

class _OnboardingView extends StatelessWidget {
  const _OnboardingView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // 1. Ambient Starry Particles (Permanent across all 4 slides)
          const Positioned.fill(child: OnboardingStarBackground()),

          // 2. Dynamic Bottom Mosque Silhouette SVG based on current slide
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: BlocBuilder<OnboardingBloc, OnboardingState>(
              buildWhen: (prev, curr) => prev.currentPage != curr.currentPage,
              builder: (context, state) {
                final currentItem = state.items[state.currentPage];
                final bgImage = currentItem.backgroundImage;

                if (bgImage == null) {
                  return const SizedBox.shrink();
                }

                return AnimatedOpacity(
                  duration: const Duration(milliseconds: 350),
                  opacity: 0.35,
                  child: SvgPicture.asset(
                    bgImage,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fitWidth,
                  ),
                );
              },
            ),
          ),

          // 3. Main PageView Content
          SafeArea(
            child: BlocBuilder<OnboardingBloc, OnboardingState>(
              builder: (context, state) {
                return Column(
                  children: [
                    // Top skip button (only visible before the final slide)
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: AppSpacing.xl,
                          top: AppSpacing.sm,
                        ),
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity: state.isLastPage ? 0.0 : 1.0,
                          child: TextButton(
                            onPressed: state.isLastPage
                                ? null
                                : () => context.read<OnboardingBloc>().add(
                                    const OnboardingSkipRequested(),
                                  ),
                            child: Text(
                              'Skip',
                              style: AppTypography.buttonSmall(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Center Content Swiper
                    Expanded(
                      child: PageView.builder(
                        itemCount: state.items.length,
                        onPageChanged: (index) {
                          context.read<OnboardingBloc>().add(
                            OnboardingPageChanged(index),
                          );
                        },
                        itemBuilder: (context, index) {
                          final item = state.items[index];
                          return Center(
                            child: SingleChildScrollView(
                              physics: const NeverScrollableScrollPhysics(),
                              child: OnboardingContentWidget(
                                title: item.title,
                                subtitle: item.subtitle,
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    // Bottom Navigation / Action Area
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xxl,
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0, 0.1),
                                end: Offset.zero,
                              ).animate(animation),
                              child: child,
                            ),
                          );
                        },
                        child: state.isLastPage
                            ? _buildActionButtons(context)
                            : _buildPageIndicator(state),
                      ),
                    ),

                    const SizedBox(height: AppSpacing.xxl),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Page Indicator Dots for Slides 1-3
  Widget _buildPageIndicator(OnboardingState state) {
    return Row(
      key: const ValueKey('indicator'),
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        state.items.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
          width: state.currentPage == index ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: state.currentPage == index
                ? AppColors.primary
                : AppColors.border,
            borderRadius: AppSpacing.roundedFull,
          ),
        ),
      ),
    );
  }

  /// 4th Screen Action Buttons matching Figma node 1:1008
  Widget _buildActionButtons(BuildContext context) {
    return Column(
      key: const ValueKey('actions'),
      mainAxisSize: MainAxisSize.min,
      children: [
        // 1. Primary Action: Create Account
        DeenButton(
          text: 'Create Account',
          onPressed: () => context.push(AppRoutes.signUp),
        ),
        const SizedBox(height: AppSpacing.lg),

        // 2. Secondary Action: Already registered? Log In
        DeenButton(
          text: 'Already registered? Log In',
          variant: DeenButtonVariant.secondary,
          onPressed: () => context.push(AppRoutes.login),
        ),
        const SizedBox(height: AppSpacing.md),

        // 3. Tertiary Action: Continue as Guest
        TextButton(
          onPressed: () => context.go(AppRoutes.dashboard),
          child: Text(
            'Continue as Guest',
            style: AppTypography.bodyMedium(color: AppColors.textSecondary),
          ),
        ),
      ],
    );
  }
}
