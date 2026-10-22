import 'package:deen_app/core/constants/asset_paths.dart';
import 'package:deen_app/features/onboarding/data/models/onboarding_item.dart';
import 'package:deen_app/features/onboarding/presentation/bloc/onboarding_event.dart';
import 'package:deen_app/features/onboarding/presentation/bloc/onboarding_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Business logic controller for the 4-step onboarding flow
class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(_initialState) {
    on<OnboardingPageChanged>(_onPageChanged);
    on<OnboardingNextRequested>(_onNextRequested);
    on<OnboardingSkipRequested>(_onSkipRequested);
  }

  static const List<OnboardingItem> _defaultItems = [
    OnboardingItem(
      pageIndex: 0,
      title: 'DEEN-STEP',
      subtitle: 'Every step counts. Track your habit, build\nconsistency, elevate your spiritual journey.',
    ),
    OnboardingItem(
      pageIndex: 1,
      title: 'DAILY PRAYERS',
      subtitle: 'Accurate prayer times, timely adhan alerts,\nand daily streak tracking for your Salah.',
      backgroundImage: AssetPaths.imgOnboardingBgScreen2,
    ),
    OnboardingItem(
      pageIndex: 2,
      title: 'SPIRITUAL REFLECTION',
      subtitle: 'Check your spiritual mood, record gratitude,\nand gain daily Islamic knowledge.',
      backgroundImage: AssetPaths.imgOnboardingBgScreen3And4,
    ),
    OnboardingItem(
      pageIndex: 3,
      title: 'DEEN-STEP',
      subtitle: 'Every step counts. Track your habit, build\nconsistency, elevate your spiritual journey.',
      backgroundImage: AssetPaths.imgOnboardingBgScreen3And4,
      showActions: true,
    ),
  ];

  static const OnboardingState _initialState = OnboardingState(
    currentPage: 0,
    items: _defaultItems,
  );

  void _onPageChanged(
    OnboardingPageChanged event,
    Emitter<OnboardingState> emit,
  ) {
    emit(state.copyWith(currentPage: event.pageIndex));
  }

  void _onNextRequested(
    OnboardingNextRequested event,
    Emitter<OnboardingState> emit,
  ) {
    if (state.currentPage < state.items.length - 1) {
      emit(state.copyWith(currentPage: state.currentPage + 1));
    }
  }

  void _onSkipRequested(
    OnboardingSkipRequested event,
    Emitter<OnboardingState> emit,
  ) {
    emit(state.copyWith(currentPage: state.items.length - 1));
  }
}
