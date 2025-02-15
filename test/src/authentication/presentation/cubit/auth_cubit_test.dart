import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tddtut/core/errors/failures.dart';
import 'package:tddtut/src/authentication/data/models/user_model.dart';
import 'package:tddtut/src/authentication/domain/usecases/create_user.dart';
import 'package:tddtut/src/authentication/domain/usecases/get_users.dart';
import 'package:tddtut/src/authentication/presentation/cubit/auth_cubit.dart';

class MockGetUsers extends Mock implements GetUsers {}

class MockCreateUsers extends Mock implements CreateUserUsecase {}

void main() {
  late GetUsers getUsers;
  late CreateUserUsecase createUser;
  late AuthCubit cubit;

  const tCreateUserParams = CreateUserParams.empty();
  const tApiFailure = ApiFailure(message: 'API Failure', statusCode: 303);
  const tUsers = [UserModel.empty()];

  setUp(() {
    getUsers = MockGetUsers();
    createUser = MockCreateUsers();
    cubit = AuthCubit(
      createUserUsecase: createUser,
      getUsersUsecase: getUsers,
    );
    registerFallbackValue(tCreateUserParams);
  });

  tearDown(() => cubit.close());

  test('initial state should be [AuthenticationInitial]', () async {
    expect(cubit.state, AuthInitial());
  });

  group('Creater User', () {
    blocTest<AuthCubit, AuthState>(
      'emits [CreatingUser, UserCreated] when user is created successfully.',
      build: () {
        when(() => createUser(tCreateUserParams)).thenAnswer(
          (_) async => const Right(null),
        );
        return cubit;
      },
      act: (cubit) => cubit.createUser(
        createdAt: tCreateUserParams.createdAt,
        name: tCreateUserParams.name,
        avatar: tCreateUserParams.avatar,
      ),
      expect: () => <AuthState>[
        UserCreating(),
        UserCreated(),
      ],
      verify: (cubit) {
        verify(() => createUser(tCreateUserParams)).called(1);
        verifyNoMoreInteractions(createUser);
      },
    );
  });

  blocTest<AuthCubit, AuthState>(
    'emits [CreatingUser, AuthenticationError] when user is created successfully.',
    build: () {
      when(() => createUser(tCreateUserParams)).thenAnswer(
        (_) async => const Left(tApiFailure),
      );
      return cubit;
    },
    act: (cubit) => cubit.createUser(
      createdAt: tCreateUserParams.createdAt,
      name: tCreateUserParams.name,
      avatar: tCreateUserParams.avatar,
    ),
    expect: () => <AuthState>[
      UserCreating(),
      AuthError(errorMessage: tApiFailure.errorMessage),
    ],
    verify: (cubit) {
      verify(() => createUser(tCreateUserParams)).called(1);
      verifyNoMoreInteractions(createUser);
    },
  );

  group('getting Users', () {
    blocTest<AuthCubit, AuthState>(
        'emits [GettingUsers, UsersFetched] when called fetchUsers function',
        build: () {
          when(() => getUsers()).thenAnswer((_) async => const Right(tUsers));
          return cubit;
        },
        act: (cubit) => cubit.fetchUsers(),
        expect: () => <AuthState>[
              GettingUsers(),
              const UsersFetched(
                users: tUsers,
              ),
            ],
        verify: (_) {
          verify(() => getUsers()).called(1);
          verifyNoMoreInteractions(getUsers);
        });

    blocTest<AuthCubit, AuthState>(
        'emits [GettingUsers, AuthError] when failed fetchUsers function',
        build: () {
          when(() => getUsers())
              .thenAnswer((_) async => const Left(tApiFailure));
          return cubit;
        },
        act: (cubit) => cubit.fetchUsers(),
        expect: () => <AuthState>[
              GettingUsers(),
              AuthError(errorMessage: tApiFailure.errorMessage),
            ],
        verify: (_) {
          verify(() => getUsers()).called(1);
          verifyNoMoreInteractions(getUsers);
        });
  });
}
