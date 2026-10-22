import 'package:deen_app/features/onboarding/data/models/onboarding_item.dart';
import 'package:equatable/equatable.dart';

/// State representation for the onboarding flow
class OnboardingState extends Equatable {
  const OnboardingState({required this.currentPage, required this.items});

  /// The active index of the PageView (0 to 3)
  final int currentPage;

  /// The list of 4 onboarding items
  final List<OnboardingItem> items;

  /// Whether current page is the last (4th) screen showing action buttons
  bool get isLastPage => currentPage == items.length - 1;

  OnboardingState copyWith({int? currentPage, List<OnboardingItem>? items}) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      items: items ?? this.items,
    );
  }

  @override
  List<Object?> get props => [currentPage, items];
}
