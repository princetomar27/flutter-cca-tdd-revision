import 'package:dartz/dartz.dart';
import 'package:tddtut/core/errors/failures.dart';
import 'package:tddtut/src/authentication/domain/entities/user.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  Future<Either<Failure, void>> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  Future<Either<Failure, List<User>>> getUsers();
}
