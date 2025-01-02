import 'package:flutter_riverpod/flutter_riverpod.dart';

enum NavigationScreen {
  home,
  orders,
  favorites,
  orderStatus
}

class NavigationState {
  final NavigationScreen currentScreen;

  NavigationState({required this.currentScreen});

  NavigationState copyWith({NavigationScreen? currentScreen}) {
    return NavigationState(
      currentScreen: currentScreen ?? this.currentScreen,
    );
  }
}

final navigationProvider = StateNotifierProvider<NavigationNotifier, NavigationState>((ref) {
  return NavigationNotifier();
});

class NavigationNotifier extends StateNotifier<NavigationState> {
  NavigationNotifier() : super(NavigationState(currentScreen: NavigationScreen.home));

  void setScreen(NavigationScreen screen) {
    state = state.copyWith(currentScreen: screen);
  }
}
