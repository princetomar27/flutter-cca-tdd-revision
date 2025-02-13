import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedefs.dart';
import '../entities/user.dart';
import '../repositories/authentication_repository.dart';

class GetUsers extends UsecaseWithoutParams<List<User>> {
  final AuthenticationRepository repository;
  GetUsers({
    required this.repository,
  });

  @override
  ResultFuture<List<User>> call() async => repository.getUsers();
}
