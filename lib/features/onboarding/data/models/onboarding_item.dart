import 'package:equatable/equatable.dart';

/// Data model representing an individual onboarding slide
class OnboardingItem extends Equatable {
  const OnboardingItem({
    required this.pageIndex,
    required this.title,
    required this.subtitle,
    this.backgroundImage,
    this.showActions = false,
  });

  final int pageIndex;
  final String title;
  final String subtitle;
  final String? backgroundImage;
  final bool showActions;

  @override
  List<Object?> get props => [
    pageIndex,
    title,
    subtitle,
    backgroundImage,
    showActions,
  ];
}
