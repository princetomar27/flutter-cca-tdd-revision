import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tddtut/src/authentication/domain/usecases/create_user.dart';
import 'package:tddtut/src/authentication/domain/usecases/get_users.dart';

import '../../domain/entities/user.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required CreateUserUsecase createUserUsecase,
    required GetUsers getUsersUsecase,
  })  : _getUsersUsecase = getUsersUsecase,
        _createUserUsecase = createUserUsecase,
        super(AuthenticationInitial()) {
    on<CreateUserEvent>(_createrUserHandler);

    on<GetUsersEvent>(_getUsersHandler);
  }

  final CreateUserUsecase _createUserUsecase;
  final GetUsers _getUsersUsecase;

  Future<void> _createrUserHandler(
    CreateUserEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const CreatingUser());
    final result = await _createUserUsecase(
      CreateUserParams(
        createdAt: event.createdAt,
        name: event.name,
        avatar: event.avatar,
      ),
    );

    result.fold(
      (failure) => emit(AuthenticationFailed(
        message: failure.errorMessage,
      )),
      (_) => emit(const UserCreated()),
    );
  }

  Future<void> _getUsersHandler(
    GetUsersEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const GettingUser());

    final result = await _getUsersUsecase();

    result.fold(
      (failure) => emit(
        AuthenticationFailed(
          message: failure.errorMessage,
        ),
      ),
      (users) => emit(
        UserLoaded(users),
      ),
    );
  }
}
