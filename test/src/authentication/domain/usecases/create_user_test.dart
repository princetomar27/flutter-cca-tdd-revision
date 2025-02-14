import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tddtut/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:tddtut/src/authentication/domain/usecases/create_user.dart';

import 'authentication_repository.mock.dart';

void main() {
  late CreateUserUsecase _usecase;
  late AuthenticationRepository _repository;

  setUp(() {
    _repository = MockAuthRepository();
    _usecase = CreateUserUsecase(repository: _repository);
  });

  const params = CreateUserParams.empty();

  test('should call the [authRepo.createUser] method', () async {
    // Arrange
    // STUB

    when(
      () => _repository.createUser(
        createdAt: any(named: 'createdAt'),
        name: any(named: 'name'),
        avatar: any(named: 'avatar'),
      ),
    ).thenAnswer((_) async => const Right(null));

    // Act
    final result = await _usecase(params);

    // Assert
    expect(result, equals(const Right<dynamic, void>(null)));

    verify(
      () => _repository.createUser(
        createdAt: params.createdAt,
        name: params.name,
        avatar: params.avatar,
      ),
    ).called(1);

    verifyNoMoreInteractions(_repository);
  });
}
