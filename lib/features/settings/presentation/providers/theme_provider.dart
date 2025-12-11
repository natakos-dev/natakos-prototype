import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'user_profile_provider.dart';
import '../../data/models/user_profile_model.dart';
import '../../data/repositories/settings_repository_impl.dart';

// Provides the current ThemeMode.
// It listens to userProfileProvider to sync with backend preference.
// Can also have local state if needed for optimistic updates.

final themeModeProvider =
    StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier(ref);
});

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  final Ref _ref;

  ThemeModeNotifier(this._ref) : super(ThemeMode.light) {
    // Listen to profile changes to sync theme
    _ref.listen<AsyncValue<UserProfileModel?>>(userProfileProvider,
        (previous, next) {
      final profile = next.valueOrNull;
      if (profile != null) {
        if (profile.themeMode == 'dark' && state != ThemeMode.dark) {
          state = ThemeMode.dark;
        } else if (profile.themeMode == 'light' && state != ThemeMode.light) {
          state = ThemeMode.light;
        }
      }
    });
  }

  void toggleTheme(bool isDark) {
    state = isDark ? ThemeMode.dark : ThemeMode.light;

    // Persist to backend
    final profileAsync = _ref.read(userProfileProvider);
    final profile = profileAsync.valueOrNull;

    if (profile != null) {
      final updated = profile.copyWith(themeMode: isDark ? 'dark' : 'light');
      _ref.read(settingsRepositoryProvider).updateUserProfile(updated);
    }
  }
}
