import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repositories/settings_repository.dart';
import '../models/setting_model.dart';
import '../models/user_profile_model.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  SettingsRepositoryImpl(this._firestore, this._auth);

  String get _userId => _auth.currentUser?.uid ?? '';

  CollectionReference<Map<String, dynamic>> get _usersCollection =>
      _firestore.collection('users');

  // Settings Sub-collection
  CollectionReference<Map<String, dynamic>> get _settingsCollection {
    if (_userId.isEmpty) throw Exception('User not logged in');
    return _usersCollection.doc(_userId).collection('settings');
  }

  @override
  Stream<List<SettingModel>> getSettings() {
    if (_userId.isEmpty) return Stream.value([]);
    return _settingsCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => SettingModel.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
    });
  }

  @override
  Future<void> updateSetting(SettingModel setting) async {
    if (_userId.isEmpty) return;
    await _settingsCollection.doc(setting.id).set(setting.toJson());
  }

  // --- Profile Implementation ---

  @override
  Stream<UserProfileModel?> getUserProfile() {
    if (_userId.isEmpty) return Stream.value(null);
    return _usersCollection.doc(_userId).snapshots().map((snapshot) {
      if (!snapshot.exists || snapshot.data() == null) return null;
      try {
        // We might store other things in user doc, so we map safely
        return UserProfileModel.fromJson({...snapshot.data()!, 'uid': _userId});
      } catch (e) {
        // If parsing fails (migration issues), return null or default
        return null;
      }
    });
  }

  @override
  Future<void> updateUserProfile(UserProfileModel profile) async {
    if (_userId.isEmpty) return;
    // Merge true to not overwrite other top-level fields if any
    await _usersCollection
        .doc(_userId)
        .set(profile.toJson(), SetOptions(merge: true));
  }
}

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepositoryImpl(
    FirebaseFirestore.instance,
    FirebaseAuth.instance,
  );
});
