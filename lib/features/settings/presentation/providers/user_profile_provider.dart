import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/user_profile_model.dart';
import '../../data/repositories/settings_repository_impl.dart';

final userProfileProvider = StreamProvider<UserProfileModel?>((ref) {
  return ref.watch(settingsRepositoryProvider).getUserProfile();
});
