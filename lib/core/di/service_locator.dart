import 'package:deen_app/core/network/dio_client.dart';
import 'package:deen_app/core/services/auth/auth_session_manager.dart';
import 'package:deen_app/core/services/location/location_service.dart';
import 'package:deen_app/core/services/notifications/push_notification_service.dart';
import 'package:deen_app/core/services/storage/secure_storage_service.dart';
import 'package:deen_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:deen_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:deen_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:deen_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:deen_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:deen_app/features/auth/domain/usecases/resend_otp_usecase.dart';
import 'package:deen_app/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:deen_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:deen_app/features/home/data/datasources/home_remote_data_source.dart';
import 'package:deen_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:deen_app/features/home/domain/repositories/home_repository.dart';
import 'package:deen_app/features/home/domain/usecases/get_current_location_usecase.dart';
import 'package:deen_app/features/home/domain/usecases/get_home_dashboard_usecase.dart';
import 'package:deen_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

/// Initialize all core dependencies and feature singletons
Future<void> initServiceLocator() async {
  // Services
  sl.registerLazySingleton<SecureStorageService>(SecureStorageService.new);
  sl.registerLazySingleton<PushNotificationService>(
    () => PushNotificationService(secureStorage: sl<SecureStorageService>()),
  );
  sl.registerLazySingleton<AuthSessionManager>(
    () => AuthSessionManager(secureStorage: sl<SecureStorageService>()),
  );

  // Network
  sl.registerLazySingleton<DioClient>(
    () => DioClient(secureStorage: sl<SecureStorageService>()),
  );

  // Auth Data Layer
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: sl<DioClient>()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl<AuthRemoteDataSource>(),
      secureStorage: sl<SecureStorageService>(),
      pushNotificationService: sl<PushNotificationService>(),
    ),
  );

  // Auth Domain Layer
  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<VerifyOtpUseCase>(
    () => VerifyOtpUseCase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<ResendOtpUseCase>(
    () => ResendOtpUseCase(sl<AuthRepository>()),
  );

  // Auth Presentation Layer
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      loginUseCase: sl<LoginUseCase>(),
      registerUseCase: sl<RegisterUseCase>(),
      verifyOtpUseCase: sl<VerifyOtpUseCase>(),
      resendOtpUseCase: sl<ResendOtpUseCase>(),
    ),
  );

  // Home Feature Layer
  sl.registerLazySingleton<LocationService>(LocationService.new);
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(client: sl<DioClient>()),
  );
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(remoteDataSource: sl<HomeRemoteDataSource>()),
  );
  sl.registerLazySingleton<GetHomeDashboardUseCase>(
    () => GetHomeDashboardUseCase(sl<HomeRepository>()),
  );
  sl.registerLazySingleton<GetCurrentLocationUseCase>(
    () => GetCurrentLocationUseCase(sl<HomeRepository>()),
  );
  sl.registerFactory<HomeBloc>(
    () => HomeBloc(
      getHomeDashboardUseCase: sl<GetHomeDashboardUseCase>(),
      getCurrentLocationUseCase: sl<GetCurrentLocationUseCase>(),
      locationService: sl<LocationService>(),
    ),
  );
}
