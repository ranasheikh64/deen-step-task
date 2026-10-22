import 'package:dartz/dartz.dart';
import 'package:deen_app/core/error/failures.dart';
import 'package:deen_app/core/services/notifications/push_notification_service.dart';
import 'package:deen_app/core/services/storage/secure_storage_service.dart';
import 'package:deen_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:deen_app/features/auth/data/datasources/social_auth_remote_data_source.dart';
import 'package:deen_app/features/auth/data/repositories/auth_failure_mapper.dart';
import 'package:deen_app/features/auth/data/repositories/auth_session_saver.dart';
import 'package:deen_app/features/auth/domain/entities/auth_result_entity.dart';
import 'package:deen_app/features/auth/domain/repositories/auth_repository.dart';

/// Concrete repository implementation managing auth data flow and failures
class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.secureStorage,
    this.socialDataSource,
    this.pushNotificationService,
  });

  final AuthRemoteDataSource remoteDataSource;
  final SocialAuthRemoteDataSource? socialDataSource;
  final SecureStorageService secureStorage;
  final PushNotificationService? pushNotificationService;

  Future<String> _resolveId(String? id) async =>
      (id != null && id.isNotEmpty) ? id : (await pushNotificationService?.getDeviceId() ?? '');

  @override
  Future<Either<Failure, AuthResultEntity>> login({
    required String email,
    required String password,
    String? deviceId,
  }) => _catch(() async {
    final res = await remoteDataSource.login(
      email: email, password: password, deviceId: await _resolveId(deviceId),
    );
    await saveAuthSession(secureStorage, res);
    return res;
  });

  @override
  Future<Either<Failure, String>> register({
    required String email,
    required String password,
    required String confirmPassword,
    String? fullName,
  }) => _catch(() => remoteDataSource.register(
    email: email, password: password,
    confirmPassword: confirmPassword, fullName: fullName,
  ));

  @override
  Future<Either<Failure, AuthResultEntity>> verifyOtp({
    required String email,
    required String otp,
    String? deviceId,
  }) => _catch(() async {
    final res = await remoteDataSource.verifyOtp(
      email: email, otp: otp, deviceId: await _resolveId(deviceId),
    );
    await saveAuthSession(secureStorage, res);
    return res;
  });

  @override
  Future<Either<Failure, String>> resendOtp({required String email}) =>
      _catch(() => remoteDataSource.resendOtp(email: email));

  @override
  Future<Either<Failure, AuthResultEntity>> guestLogin({String? deviceId}) =>
      _catch(() async {
        final res = await remoteDataSource.guestLogin(
          deviceId: await _resolveId(deviceId),
        );
        await saveAuthSession(secureStorage, res);
        return res;
      });

  @override
  Future<Either<Failure, AuthResultEntity>> socialAuth({
    required String idToken,
    required String provider,
    String? deviceId,
  }) => _catch(() async {
    final devId = await _resolveId(deviceId);
    final res = await (socialDataSource ??
            SocialAuthRemoteDataSourceImpl(client: (remoteDataSource as AuthRemoteDataSourceImpl).client))
        .socialAuth(idToken: idToken, provider: provider, deviceId: devId);
    await saveAuthSession(secureStorage, res);
    return res;
  });

  @override
  Future<Either<Failure, void>> logout() => _catch(() async {
    final ref = await secureStorage.getRefreshToken() ?? '';
    try {
      if (ref.isNotEmpty) await remoteDataSource.logout(refreshToken: ref);
    } finally {
      await secureStorage.clearAll();
    }
  });

  Future<Either<Failure, T>> _catch<T>(Future<T> Function() fn) async {
    try {
      return Right(await fn());
    } on Exception catch (e) {
      return Left(mapAuthError(e));
    }
  }
}
