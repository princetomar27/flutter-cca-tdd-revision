import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tddtut/src/authentication/domain/usecases/create_user.dart';
import 'package:tddtut/src/authentication/domain/usecases/get_users.dart';
import 'package:tddtut/src/authentication/presentation/cubit/auth_cubit.dart';

class MockGetUsers extends Mock implements GetUsers {}

class MockCreateUsers extends Mock implements CreateUserUsecase {}

void main() {
  late GetUsers getUsers;
  late CreateUserUsecase createUser;
  late AuthCubit cubit;

  setUp(() {
    getUsers = MockGetUsers();
    createUser = MockCreateUsers();
    cubit = AuthCubit(
      createUserUsecase: createUser,
      getUsersUsecase: getUsers,
    );
  });
}
