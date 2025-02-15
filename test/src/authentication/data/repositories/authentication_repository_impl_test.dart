import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tddtut/core/errors/exceptions.dart';
import 'package:tddtut/core/errors/failures.dart';
import 'package:tddtut/src/authentication/data/datasources/authentication_datasources.dart';
import 'package:tddtut/src/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:tddtut/src/authentication/domain/entities/user.dart';

class MockAuthDatasourceImpl extends Mock implements AuthenticationDatasource {}

void main() {
  late AuthenticationDatasource authDatasource;
  late AuthenticationRepositoryImpl authRepositoryImpl;

  setUp(() {
    authDatasource = MockAuthDatasourceImpl();
    authRepositoryImpl =
        AuthenticationRepositoryImpl(datasource: authDatasource);
  });

  const createdAt = 'createdAt';
  const name = 'name';
  const avatar = 'avatar';

  const tException =
      ServerException(message: 'Internal Server Error', statusCode: 500);

  group('createrUser', () {
    test(
      'should call the [AuthenticationDatasource.createrUser] and executes successfully',
      () async {
        // Check datasource calls the createUser(){} with right data
        when(
          () => authDatasource.createUser(
            createdAt: any(named: 'createdAt'),
            name: any(named: 'name'),
            avatar: any(
              named: 'avatar',
            ),
          ),
        ).thenAnswer((_) async {
          Future.value();
        });

        // Act
        final result = await authRepositoryImpl.createUser(
          createdAt: createdAt,
          name: name,
          avatar: avatar,
        );

        // Assert
        expect(result, equals(const Right(null)));

        verify(() => authDatasource.createUser(
              createdAt: createdAt,
              name: name,
              avatar: avatar,
            )).called(1);

        verifyNoMoreInteractions(authDatasource);
      },
    );

    test(
      'should return a [ServerFailure] when the call to the datasourcesource is unsuccessfull',
      () async {
        // Arrange
        when(
          () => authDatasource.createUser(
            createdAt: any(named: 'createdAt'),
            name: any(named: 'name'),
            avatar: any(
              named: 'avatar',
            ),
          ),
        ).thenThrow(
          tException,
        );

        // Act
        final result = await authRepositoryImpl.createUser(
          createdAt: createdAt,
          name: name,
          avatar: avatar,
        );

        expect(
          result,
          equals(
            Left(
              ServerFailure(
                message: tException.message,
                statusCode: tException.statusCode,
              ),
            ),
          ),
        );

        verify(() => authDatasource.createUser(
              createdAt: createdAt,
              name: name,
              avatar: avatar,
            )).called(1);
        verifyNoMoreInteractions(authDatasource);
      },
    );
  });

  group('getUsers', () {
    test(
        'should call the [AuthenticationDatasource.getUsers] and return [User] when call to datasource is successfull',
        () async {
      when(() => authDatasource.getUsers()).thenAnswer(
        (_) async => [],
      );

      final result = await authRepositoryImpl.getUsers();
      expect(result, isA<Right<dynamic, List<User>>>());

      verify(() => authDatasource.getUsers()).called(1);
      verifyNoMoreInteractions(authDatasource);
    });

    test(
        'should call the [AuthenticationDatasource.getUsers] and return ServerFailure when call to datasource is unsuccessfull',
        () async {
      when(() => authDatasource.getUsers()).thenThrow(tException);

      final result = await authRepositoryImpl.getUsers();
      expect(result, equals(Left(ServerFailure.fromException(tException))));

      verify(() => authDatasource.getUsers()).called(1);
      verifyNoMoreInteractions(authDatasource);
    });
  });
}
