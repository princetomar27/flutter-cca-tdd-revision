import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tddtut/src/authentication/data/models/user_model.dart';
import 'package:tddtut/src/authentication/domain/entities/user.dart';
import 'package:tddtut/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:tddtut/src/authentication/domain/usecases/get_users.dart';

import 'authentication_repository.mock.dart';

void main() {
  late GetUsers usecase;
  late AuthenticationRepository repository;

  setUp(() {
    repository = MockAuthRepository();
    usecase = GetUsers(repository: repository);
  });

  final testResponse = [
    const UserModel.empty(),
  ];

  testWidgets('should call [AuthRepo.getUsers] and return List<User>[]',
      (tester) async {
    // Arrange
    when(() => repository.getUsers())
        .thenAnswer((_) async => Right(testResponse));
    // Act
    final result = await usecase();
    // Assert
    expect(result, equals(Right<dynamic, List<User>>(testResponse)));
    verify(() => repository.getUsers()).called(1);

    verifyNoMoreInteractions(repository);
  });
}
