import 'package:dartz/dartz.dart';

import '../errors/failures.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;

typedef ResultFutureVoid = Future<Either<Failure, void>>;

typedef DataMap = Map<String, dynamic>;
