import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tddtut/src/authentication/domain/usecases/create_user.dart';
import 'package:tddtut/src/authentication/domain/usecases/get_users.dart';
import '../../domain/entities/user.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required CreateUserUsecase createUserUsecase,
    required GetUsers getUsersUsecase,
  })  : _createUserUsecase = createUserUsecase,
        _getUsersUsecase = getUsersUsecase,
        super(AuthInitial());

  final CreateUserUsecase _createUserUsecase;
  final GetUsers _getUsersUsecase;

  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    emit(UserCreating());
    final result = await _createUserUsecase(
      CreateUserParams(createdAt: createdAt, name: name, avatar: avatar),
    );

    result.fold(
      (failure) => emit(
        AuthError(
          errorMessage: failure.errorMessage,
        ),
      ),
      (_) => emit(UserCreated()),
    );
  }

  Future<void> fetchUsers() async {
    emit(GettingUsers());
    final result = await _getUsersUsecase();

    result.fold(
      (failure) => emit(AuthError(errorMessage: failure.errorMessage)),
      (users) => emit(UsersFetched(users: users)),
    );
  }
}
