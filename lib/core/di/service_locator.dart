import 'package:deen_app/core/network/dio_client.dart';
import 'package:deen_app/core/services/auth/auth_session_manager.dart';
import 'package:deen_app/core/services/location/location_service.dart';
import 'package:deen_app/core/services/notifications/push_notification_service.dart';
import 'package:deen_app/core/services/storage/secure_storage_service.dart';
import 'package:deen_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:deen_app/features/auth/data/datasources/social_auth_remote_data_source.dart';
import 'package:deen_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:deen_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:deen_app/features/auth/domain/usecases/guest_login_usecase.dart';
import 'package:deen_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:deen_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:deen_app/features/auth/domain/usecases/resend_otp_usecase.dart';
import 'package:deen_app/features/auth/domain/usecases/social_auth_usecase.dart';
import 'package:deen_app/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:deen_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:deen_app/features/home/data/datasources/home_remote_data_source.dart';
import 'package:deen_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:deen_app/features/home/domain/repositories/home_repository.dart';
import 'package:deen_app/features/home/domain/usecases/get_current_location_usecase.dart';
import 'package:deen_app/features/home/domain/usecases/get_home_dashboard_usecase.dart';
import 'package:deen_app/features/home/domain/usecases/update_location_usecase.dart';
import 'package:deen_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

/// Initialize all core dependencies and feature singletons
Future<void> initServiceLocator() async {
  // Services & Network
  sl.registerLazySingleton<SecureStorageService>(SecureStorageService.new);
  sl.registerLazySingleton<PushNotificationService>(
    () => PushNotificationService(secureStorage: sl<SecureStorageService>()),
  );
  sl.registerLazySingleton<AuthSessionManager>(
    () => AuthSessionManager(secureStorage: sl<SecureStorageService>()),
  );
  sl.registerLazySingleton<DioClient>(
    () => DioClient(secureStorage: sl<SecureStorageService>()),
  );

  // Auth Data Layer
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: sl<DioClient>()),
  );
  sl.registerLazySingleton<SocialAuthRemoteDataSource>(
    () => SocialAuthRemoteDataSourceImpl(client: sl<DioClient>()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl<AuthRemoteDataSource>(),
      socialDataSource: sl<SocialAuthRemoteDataSource>(),
      secureStorage: sl<SecureStorageService>(),
      pushNotificationService: sl<PushNotificationService>(),
    ),
  );

  // Auth Domain & Presentation
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton<VerifyOtpUseCase>(() => VerifyOtpUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton<ResendOtpUseCase>(() => ResendOtpUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton<SocialAuthUseCase>(() => SocialAuthUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton<GuestLoginUseCase>(() => GuestLoginUseCase(sl<AuthRepository>()));
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      loginUseCase: sl<LoginUseCase>(),
      registerUseCase: sl<RegisterUseCase>(),
      verifyOtpUseCase: sl<VerifyOtpUseCase>(),
      resendOtpUseCase: sl<ResendOtpUseCase>(),
      socialAuthUseCase: sl<SocialAuthUseCase>(),
      guestLoginUseCase: sl<GuestLoginUseCase>(),
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
  sl.registerLazySingleton<UpdateLocationUseCase>(
    () => UpdateLocationUseCase(sl<HomeRepository>()),
  );
  sl.registerFactory<HomeBloc>(
    () => HomeBloc(
      getHomeDashboardUseCase: sl<GetHomeDashboardUseCase>(),
      getCurrentLocationUseCase: sl<GetCurrentLocationUseCase>(),
      updateLocationUseCase: sl<UpdateLocationUseCase>(),
      locationService: sl<LocationService>(),
    ),
  );
}
