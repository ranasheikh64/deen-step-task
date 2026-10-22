import 'package:equatable/equatable.dart';

/// Entity representing user's geographic location
class UserLocationEntity extends Equatable {
  const UserLocationEntity({
    this.latitude = '0.0',
    this.longitude = '0.0',
    this.address = '',
    this.city = '',
    this.countryCode = '',
    this.timezone = '',
  });

  final String latitude;
  final String longitude;
  final String address;
  final String city;
  final String countryCode;
  final String timezone;

  @override
  List<Object?> get props => [
    latitude,
    longitude,
    address,
    city,
    countryCode,
    timezone,
  ];
}
