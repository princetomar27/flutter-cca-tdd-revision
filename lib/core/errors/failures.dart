import 'package:equatable/equatable.dart';

import 'exceptions.dart';

abstract class Failure extends Equatable {
  const Failure({required this.message, required this.statusCode});

  final String message;
  final int statusCode;

  @override
  List<Object> get props => [message, statusCode];
}

class ServerFailure extends Failure {
  ServerFailure.fromException(ServerException exception)
      : this(message: exception.message, statusCode: exception.statusCode);

  const ServerFailure({required super.message, required super.statusCode});
}

class ApiFailure extends Failure {
  const ApiFailure({required super.message, required super.statusCode});
}
