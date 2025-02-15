import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'package:tddtut/src/authentication/data/datasources/authentication_datasources.dart';
import 'package:tddtut/src/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:tddtut/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:tddtut/src/authentication/domain/usecases/create_user.dart';
import 'package:tddtut/src/authentication/domain/usecases/get_users.dart';
import 'package:tddtut/src/authentication/presentation/cubit/auth_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ✅ Core dependencies
  sl.registerLazySingleton<http.Client>(() => http.Client());

  // ✅ Data Sources
  sl.registerLazySingleton<AuthenticationDatasource>(
    () => AuthenticationDatasourceImpl(client: sl()),
  );

  // ✅ Repositories
  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(datasource: sl()),
  );

  // ✅ Use Cases
  sl.registerLazySingleton(() => CreateUserUsecase(repository: sl()));
  sl.registerLazySingleton(() => GetUsers(repository: sl()));

  // ✅ Cubits
  sl.registerFactory(
    () => AuthCubit(
      createUserUsecase: sl(),
      getUsersUsecase: sl(),
    ),
  );
}
