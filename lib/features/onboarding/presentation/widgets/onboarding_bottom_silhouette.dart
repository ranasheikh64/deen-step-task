import 'package:deen_app/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:deen_app/features/onboarding/presentation/bloc/onboarding_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Dynamic bottom mosque silhouette positioned at the bottom of onboarding.
/// Shows screen 2, 3, and 4 rising silhouettes from Figma.
class OnboardingBottomSilhouette extends StatelessWidget {
  const OnboardingBottomSilhouette({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: BlocBuilder<OnboardingBloc, OnboardingState>(
        buildWhen: (prev, curr) => prev.currentPage != curr.currentPage,
        builder: (context, state) {
          final currentItem = state.items[state.currentPage];
          final bgImage = currentItem.backgroundImage;

          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            child: bgImage == null
                ? const SizedBox.shrink(key: ValueKey('none'))
                : Opacity(
                    key: ValueKey(bgImage),
                    opacity: 0.6,
                    child: SvgPicture.asset(
                      bgImage,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
          );
        },
      ),
    );
  }
}
