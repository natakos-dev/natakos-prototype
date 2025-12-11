import '../../data/models/setting_model.dart';
import '../../data/models/user_profile_model.dart';

abstract class SettingsRepository {
  Stream<List<SettingModel>> getSettings();
  Future<void> updateSetting(SettingModel setting);

  // Profile Methods
  Stream<UserProfileModel?> getUserProfile();
  Future<void> updateUserProfile(UserProfileModel profile);
}
