import 'package:flutter_riverpod/flutter_riverpod.dart';

class DarkThemeNotifer extends StateNotifier<bool> {
  DarkThemeNotifer() : super(true);

  toggleDarkTheme() {
    state = !state;
  }
}

final darkProvider = StateNotifierProvider<DarkThemeNotifer, bool>(
  (ref) => DarkThemeNotifer(),
);
