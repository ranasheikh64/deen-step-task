import 'package:deen_app/core/network/api_endpoints.dart';
import 'package:deen_app/core/network/dio_client.dart';
import 'package:deen_app/features/home/data/models/home_dashboard_model.dart';
import 'package:deen_app/features/home/data/models/user_location_model.dart';

/// Contract for Home remote API requests
abstract class HomeRemoteDataSource {
  Future<HomeDashboardModel> getHomeDashboard();
  Future<UserLocationModel> getCurrentLocation();
  Future<UserLocationModel> updateLocation({
    required String latitude,
    required String longitude,
  });
}

/// Implementation using centralized DioClient
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  const HomeRemoteDataSourceImpl({required this.client});

  final DioClient client;

  @override
  Future<HomeDashboardModel> getHomeDashboard() async {
    final response = await client.get<Map<String, dynamic>>(
      ApiEndpoints.userDashboard,
    );
    return HomeDashboardModel.fromJson(response.data!);
  }

  @override
  Future<UserLocationModel> getCurrentLocation() async {
    final response = await client.get<Map<String, dynamic>>(
      ApiEndpoints.userCurrentLocation,
    );
    final data = response.data?['data'] as Map<String, dynamic>? ??
        response.data ??
        {};
    return UserLocationModel.fromJson(data);
  }

  @override
  Future<UserLocationModel> updateLocation({
    required String latitude,
    required String longitude,
  }) async {
    final formattedLat = _formatCoordinate(latitude);
    final formattedLng = _formatCoordinate(longitude);
    final response = await client.patch<Map<String, dynamic>>(
      ApiEndpoints.userLocationUpdate,
      data: {'latitude': formattedLat, 'longitude': formattedLng},
    );
    final data = response.data?['data'] as Map<String, dynamic>? ??
        response.data ??
        {};
    return UserLocationModel.fromJson(data);
  }

  String _formatCoordinate(String coord) {
    final parsed = double.tryParse(coord.trim());
    if (parsed != null) {
      return parsed.toStringAsFixed(6);
    }
    return coord.trim();
  }
}
