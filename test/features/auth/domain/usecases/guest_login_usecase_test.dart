import 'package:dartz/dartz.dart';
import 'package:deen_app/core/error/failures.dart';
import 'package:deen_app/features/auth/domain/entities/auth_result_entity.dart';
import 'package:deen_app/features/auth/domain/entities/user_entity.dart';
import 'package:deen_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:deen_app/features/auth/domain/usecases/guest_login_usecase.dart';
import 'package:flutter_test/flutter_test.dart';

class _MockAuthRepository extends Fake implements AuthRepository {
  _MockAuthRepository();

  String? capturedDeviceId;

  @override
  Future<Either<Failure, AuthResultEntity>> guestLogin({String? deviceId}) async {
    capturedDeviceId = deviceId;
    return const Right(
      AuthResultEntity(
        accessToken: 'guest_access_token',
        refreshToken: 'guest_refresh_token',
        detail: 'Login successful.',
        user: UserEntity(id: 269, fullName: 'anonymous', isVerified: false),
      ),
    );
  }
}

void main() {
  test('GuestLoginUseCase delegates to repository and returns tokens', () async {
    final mockRepo = _MockAuthRepository();
    final useCase = GuestLoginUseCase(mockRepo);

    final res = await useCase(deviceId: 'test_fcm_token');

    expect(mockRepo.capturedDeviceId, 'test_fcm_token');
    expect(res.isRight(), isTrue);
    res.fold(
      (_) => fail('Expected Right'),
      (entity) {
        expect(entity.accessToken, 'guest_access_token');
        expect(entity.refreshToken, 'guest_refresh_token');
        expect(entity.user.id, 269);
        expect(entity.user.fullName, 'anonymous');
      },
    );
  });
}
