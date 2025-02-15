import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/typedefs.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../datasources/authentication_datasources.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationDatasource datasource;

  AuthenticationRepositoryImpl({required this.datasource});

  @override
  ResultFutureVoid createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async {
    // call the remote datasource

    // check if the method returns the proper data

    // check if when the datasource throws an exception, we return a failure
    // and if it doesn't throw an exception, we return a success data
    try {
      final result = await datasource.createUser(
        createdAt: createdAt,
        name: name,
        avatar: avatar,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(
        ServerFailure.fromException(e),
      );
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    try {
      final result = await datasource.getUsers();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
