import 'package:deen_app/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:deen_app/features/onboarding/presentation/bloc/onboarding_event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OnboardingBloc Tests', () {
    late OnboardingBloc bloc;

    setUp(() {
      bloc = OnboardingBloc();
    });

    tearDown(() async {
      await bloc.close();
    });

    test('initial state has currentPage 0 and 4 items', () {
      expect(bloc.state.currentPage, equals(0));
      expect(bloc.state.items.length, equals(4));
      expect(bloc.state.isLastPage, isFalse);
    });

    test(
      'emits state with updated currentPage on OnboardingPageChanged',
      () async {
        bloc.add(const OnboardingPageChanged(2));
        await expectLater(
          bloc.stream,
          emits(predicate((state) => (state as dynamic).currentPage == 2)),
        );
      },
    );

    test('emits last page state on OnboardingSkipRequested', () async {
      bloc.add(const OnboardingSkipRequested());
      await expectLater(
        bloc.stream,
        emits(predicate((state) => (state as dynamic).isLastPage == true)),
      );
    });
  });
}
