import 'package:equatable/equatable.dart';

/// Events handled by OnboardingBloc
abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object?> get props => [];
}

/// Triggered when the user swipes or changes the PageView page
class OnboardingPageChanged extends OnboardingEvent {
  const OnboardingPageChanged(this.pageIndex);

  final int pageIndex;

  @override
  List<Object?> get props => [pageIndex];
}

/// Triggered when user requests to jump to the next page
class OnboardingNextRequested extends OnboardingEvent {
  const OnboardingNextRequested();
}

/// Triggered when user clicks skip to jump directly to the last action page
class OnboardingSkipRequested extends OnboardingEvent {
  const OnboardingSkipRequested();
}
