import 'package:deen_app/core/di/service_locator.dart';
import 'package:deen_app/core/routing/app_routes.dart';
import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/widgets/deen_snackbar.dart';
import 'package:deen_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:deen_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:deen_app/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:deen_app/features/onboarding/presentation/bloc/onboarding_event.dart';
import 'package:deen_app/features/onboarding/presentation/bloc/onboarding_state.dart';
import 'package:deen_app/features/onboarding/presentation/widgets/onboarding_action_buttons.dart';
import 'package:deen_app/features/onboarding/presentation/widgets/onboarding_bottom_silhouette.dart';
import 'package:deen_app/features/onboarding/presentation/widgets/onboarding_content_widget.dart';
import 'package:deen_app/features/onboarding/presentation/widgets/onboarding_page_indicator.dart';
import 'package:deen_app/features/onboarding/presentation/widgets/onboarding_skip_button.dart';
import 'package:deen_app/features/onboarding/presentation/widgets/onboarding_star_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// Stateless Onboarding Screen powered by [OnboardingBloc].
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key, this.authBloc});

  final AuthBloc? authBloc;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => OnboardingBloc()),
        BlocProvider(
          create: (_) =>
              authBloc ??
              (sl.isRegistered<AuthBloc>() ? sl<AuthBloc>() : AuthBloc()),
        ),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            context.go(AppRoutes.dashboard);
          } else if (state is AuthFailureState) {
            DeenSnackBar.showError(context, state.errorMessage);
          }
        },
        child: const _OnboardingView(),
      ),
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
          const Positioned.fill(child: OnboardingStarBackground()),
          const OnboardingBottomSilhouette(),
          SafeArea(
            child: BlocBuilder<OnboardingBloc, OnboardingState>(
              builder: (context, state) => Column(
                children: [
                  OnboardingSkipButton(isLastPage: state.isLastPage),
                  Expanded(
                    child: PageView.builder(
                      itemCount: state.items.length,
                      onPageChanged: (i) => context
                          .read<OnboardingBloc>()
                          .add(OnboardingPageChanged(i)),
                      itemBuilder: (context, index) => Center(
                        child: SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: OnboardingContentWidget(
                            title: state.items[index].title,
                            subtitle: state.items[index].subtitle,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xxl,
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: state.isLastPage
                          ? const OnboardingActionButtons()
                          : OnboardingPageIndicator(
                              itemCount: state.items.length,
                              currentPage: state.currentPage,
                            ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
