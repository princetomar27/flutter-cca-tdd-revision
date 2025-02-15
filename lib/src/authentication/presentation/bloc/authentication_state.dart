part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {}

class CreatingUser extends AuthenticationState {
  const CreatingUser();
}

class GettingUser extends AuthenticationState {
  const GettingUser();
}

class UserCreated extends AuthenticationState {
  const UserCreated();
}

class UserLoaded extends AuthenticationState {
  const UserLoaded(this.users);
  final List<User> users;

  @override
  List<Object> get props => users.map((user) => user.id).toList();
}

class AuthenticationFailed extends AuthenticationState {
  final String message;
  const AuthenticationFailed({required this.message});

  @override
  List<Object> get props => [message];
}
