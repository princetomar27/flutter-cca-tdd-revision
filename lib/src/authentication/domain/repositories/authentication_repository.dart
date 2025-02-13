import 'package:tddtut/core/utils/typedefs.dart';
import 'package:tddtut/src/authentication/domain/entities/user.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  ResultFutureVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  ResultFuture<List<User>> getUsers();
}
