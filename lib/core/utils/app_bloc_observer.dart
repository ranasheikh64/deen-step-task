import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Global BlocObserver that logs events, state transitions, and errors
class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    if (kDebugMode) {
      debugPrint('🏗️ [BLOC CREATED] ${bloc.runtimeType}');
    }
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    if (kDebugMode) {
      debugPrint('🎯 [BLOC EVENT] ${bloc.runtimeType} -> $event');
    }
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    if (kDebugMode) {
      debugPrint(
        '🔄 [BLOC CHANGE] ${bloc.runtimeType} -> '
        'Current: ${change.currentState.runtimeType} | '
        'Next: ${change.nextState.runtimeType}',
      );
    }
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    if (kDebugMode) {
      debugPrint(
        '⚡ [BLOC TRANSITION] ${bloc.runtimeType} -> '
        'Event: ${transition.event.runtimeType} => '
        'Next: ${transition.nextState}',
      );
    }
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    if (kDebugMode) {
      debugPrint('💥 [BLOC ERROR] ${bloc.runtimeType} -> $error');
      debugPrint(stackTrace.toString());
    }
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    if (kDebugMode) {
      debugPrint('🛑 [BLOC CLOSED] ${bloc.runtimeType}');
    }
  }
}
