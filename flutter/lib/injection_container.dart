import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/db/database_helper.dart';
import 'core/db/database_user_helper.dart';
import 'features/users/data/datasources/users_local_data_source.dart';
import 'features/users/data/datasources/users_remote_data_source.dart';
import 'features/users/data/repositories/users_repository_impl.dart';
import 'features/users/domain/repositories/users_repository.dart';
import 'features/users/presentation/providers/users/users_provider.dart';

final sl = GetIt.instance;
Future<void> init() async {

// Providers
 sl.registerFactory(
        () => UsersProvider(),
  );

  // Repository
  sl.registerLazySingleton<UsersRepository>(
        () => UsersRepositoryImpl(
        localDataSource: sl(),
        remoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<UsersRepositoryImpl>(
        () => UsersRepositoryImpl(
        localDataSource: sl(),
        remoteDataSource: sl(),
    ),
  );


  // Data sources
  sl.registerLazySingleton<UsersRemoteDataSource>(
        () => UsersRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<UsersLocalDataSource>(
        () => UsersLocalDataSourceImpl(databaseHelper: sl()),
  );

  /* Core */
  sl.registerLazySingleton(() => DatabaseHelper());
  sl.registerLazySingleton(() => UserDatabaseHelper());

  /* External libraries */
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
}