import 'package:get_it/get_it.dart';
import 'package:tddtut/src/authentication/data/datasources/authentication_datasources.dart';
import 'package:tddtut/src/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:tddtut/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:tddtut/src/authentication/domain/usecases/create_user.dart';
import 'package:tddtut/src/authentication/domain/usecases/get_users.dart';
import 'package:tddtut/src/authentication/presentation/cubit/auth_cubit.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
    () => AuthCubit(
      createUserUsecase: sl(),
      getUsersUsecase: sl(),
    ),
  );

  // Usecases
  sl.registerLazySingleton(() => CreateUserUsecase(repository: sl()));
  sl.registerLazySingleton(() => GetUsers(repository: sl()));

  // Repositories
  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
      datasource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AuthenticationDatasource>(
    () => AuthenticationDatasourceImpl(
      client: sl(),
    ),
  );

  // HTTP client
  sl.registerLazySingleton(() => http.Client.new);
}
