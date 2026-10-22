import 'package:deen_app/features/home/domain/entities/user_location_entity.dart';

/// Data transfer model for UserLocationEntity
class UserLocationModel extends UserLocationEntity {
  const UserLocationModel({
    super.latitude,
    super.longitude,
    super.address,
    super.city,
    super.countryCode,
    super.timezone,
  });

  factory UserLocationModel.fromJson(Map<String, dynamic> json) {
    return UserLocationModel(
      latitude: json['latitude']?.toString() ?? '0.0',
      longitude: json['longitude']?.toString() ?? '0.0',
      address: json['address'] as String? ?? '',
      city: json['city'] as String? ?? '',
      countryCode: json['country_code'] as String? ?? '',
      timezone: json['timezone'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'city': city,
      'country_code': countryCode,
      'timezone': timezone,
    };
  }
}
