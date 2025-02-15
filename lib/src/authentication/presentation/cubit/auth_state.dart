part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class UserCreating extends AuthState {}

final class UserCreated extends AuthState {}

final class AuthError extends AuthState {
  final String errorMessage;

  const AuthError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

final class GettingUsers extends AuthState {}

final class UsersFetched extends AuthState {
  final List<User> users;

  const UsersFetched({required this.users});

  @override
  List<Object> get props => [users];
}
