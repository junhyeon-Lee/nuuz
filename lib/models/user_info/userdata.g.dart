// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userdata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserData _$$_UserDataFromJson(Map<String, dynamic> json) => _$_UserData(
      user_id: json['user_id'] as String?,
      name: json['name'] as String?,
      birth_date: json['birth_date'] as String?,
      gender: json['gender'] as String?,
      email: json['email'] as String?,
      profile_image: json['profile_image'] as String?,
      social_token: json['social_token'] as String?,
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
      is_deleted: json['is_deleted'] as int?,
      nick_name: json['nick_name'] as String?,
      login_type: json['login_type'] as String?,
      introduction: json['introduction'] as String?,
      role: json['role'] as String?,
      password: json['password'] as String?,
      shipping: json['shipping'] as String?,
      comment: json['comment'] as String?,
      post: json['post'] as String?,
      privacy_settings: json['privacy_settings'] == null
          ? null
          : PrivacySettingsModel.fromJson(
              json['privacy_settings'] as Map<String, dynamic>),
      notification_settings: json['notification_settings'] == null
          ? null
          : NotificationSettingsModel.fromJson(
              json['notification_settings'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_UserDataToJson(_$_UserData instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'name': instance.name,
      'birth_date': instance.birth_date,
      'gender': instance.gender,
      'email': instance.email,
      'profile_image': instance.profile_image,
      'social_token': instance.social_token,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'is_deleted': instance.is_deleted,
      'nick_name': instance.nick_name,
      'login_type': instance.login_type,
      'introduction': instance.introduction,
      'role': instance.role,
      'password': instance.password,
      'shipping': instance.shipping,
      'comment': instance.comment,
      'post': instance.post,
      'privacy_settings': instance.privacy_settings,
      'notification_settings': instance.notification_settings,
    };
