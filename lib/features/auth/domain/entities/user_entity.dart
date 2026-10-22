import 'package:equatable/equatable.dart';

/// Domain entity representing an authenticated or registered user
class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    this.email,
    this.fullName,
    this.mobile,
    this.isVerified = false,
    this.firebaseUid,
  });

  final int id;
  final String? email;
  final String? fullName;
  final String? mobile;
  final bool isVerified;
  final String? firebaseUid;

  @override
  List<Object?> get props => [
    id,
    email,
    fullName,
    mobile,
    isVerified,
    firebaseUid,
  ];
}
