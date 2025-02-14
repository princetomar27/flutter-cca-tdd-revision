import 'package:equatable/equatable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedefs.dart';
import '../repositories/authentication_repository.dart';

class CreateUserUsecase extends UsecaseWithParams<void, CreateUserParams> {
  CreateUserUsecase({required this.repository});

  final AuthenticationRepository repository;

  @override
  ResultFutureVoid call(CreateUserParams params) async => repository.createUser(
        createdAt: params.createdAt,
        name: params.name,
        avatar: params.avatar,
      );
}

class CreateUserParams extends Equatable {
  final String createdAt;
  final String name;
  final String avatar;

  const CreateUserParams.empty()
      : this(
          createdAt: '_empty.createdAt',
          name: '_empty.name',
          avatar: '_empty.avatar',
        );

  const CreateUserParams({
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  @override
  List<Object?> get props => [
        createdAt,
        name,
        avatar,
      ];
}
