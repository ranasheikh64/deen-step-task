import 'package:deen_app/core/network/dio_client.dart';
import 'package:deen_app/core/services/storage/secure_storage_service.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

/// Initialize all core dependencies and feature singletons
Future<void> initServiceLocator() async {
  // Services
  sl.registerLazySingleton<SecureStorageService>(SecureStorageService.new);

  // Network
  sl.registerLazySingleton<DioClient>(
    () => DioClient(secureStorage: sl<SecureStorageService>()),
  );
}
