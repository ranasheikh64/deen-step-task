import 'package:deen_app/features/auth/domain/entities/user_entity.dart';

/// Data transfer model for UserEntity
class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    super.email,
    super.fullName,
    super.mobile,
    super.isVerified = false,
    super.firebaseUid,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int? ?? 0,
      email: json['email'] as String?,
      fullName: json['full_name'] as String?,
      mobile: json['mobile'] as String?,
      isVerified: json['is_verified'] as bool? ?? false,
      firebaseUid: json['firebase_uid'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'full_name': fullName,
      'mobile': mobile,
      'is_verified': isVerified,
      'firebase_uid': firebaseUid,
    };
  }
}
