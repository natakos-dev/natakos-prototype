// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileModelImpl _$$UserProfileModelImplFromJson(
        Map<String, dynamic> json) =>
    _$UserProfileModelImpl(
      uid: json['uid'] as String,
      name: json['name'] as String,
      kosName: json['kosName'] as String,
      kosAddress: json['kosAddress'] as String,
      themeMode: json['themeMode'] as String? ?? 'light',
      isDataComplete: json['isDataComplete'] as bool? ?? false,
    );

Map<String, dynamic> _$$UserProfileModelImplToJson(
        _$UserProfileModelImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'kosName': instance.kosName,
      'kosAddress': instance.kosAddress,
      'themeMode': instance.themeMode,
      'isDataComplete': instance.isDataComplete,
    };
