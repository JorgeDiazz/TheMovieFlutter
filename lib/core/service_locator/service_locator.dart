import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:the_movie_db/core/constants/environment.dart';
import 'package:the_movie_db/core/constants/network_constants.dart';
import 'package:the_movie_db/core/use_cases/use_cases.dart';
import 'package:the_movie_db/core/utils/network_info.dart';
import 'package:the_movie_db/core/utils/test_config.dart';
import 'package:the_movie_db/features/popular_movies/domain/entities/movie.dart';
import 'package:the_movie_db/features/popular_movies/domain/repositories/movies_repository.dart';
import 'package:the_movie_db/features/popular_movies/domain/use_cases/get_movie_detail_use_case.dart';
import 'package:the_movie_db/features/popular_movies/domain/use_cases/get_popular_movies_use_case.dart';
import 'package:the_movie_db/features/popular_movies/infrastructure/datasources/movies_datasource.dart';
import 'package:the_movie_db/features/popular_movies/infrastructure/datasources/movies_local_datasource.dart';
import 'package:the_movie_db/features/popular_movies/infrastructure/datasources/movies_local_datasource_impl.dart';
import 'package:the_movie_db/features/popular_movies/infrastructure/datasources/movies_remote_datasource_impl.dart';
import 'package:the_movie_db/features/popular_movies/infrastructure/models/local/movie_local.dart';
import 'package:the_movie_db/features/popular_movies/infrastructure/repositories/movies_repository_impl.dart';

final serviceLocator = GetIt.instance;

Future<void> initServiceLocator() async {
  if (!TestConfig.inTestMode) {
    final moviesBox = await _initLocalDatabase();
    await _initNetworkServices();
    await _initMoviesLocator(moviesBox);
  }
}

Future<Box<MovieLocal>> _initLocalDatabase() async {
  Hive.registerAdapter(MovieLocalAdapter());
  return await Hive.openBox<MovieLocal>('movies');
}

Future<void> _initNetworkServices() async {
  serviceLocator
    ..registerLazySingleton<Dio>(
      () => Dio(
        BaseOptions(baseUrl: NetworkConstants.baseUrl, headers: {
          'Authorization': 'Bearer ${Environment.theMovieDbApiKey}',
          'accept': 'application/json'
        }, queryParameters: {
          'language': 'en-US',
        }),
      ),
    )
    ..registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker.instance),
    );
}

Future<void> _initMoviesLocator(Box<MovieLocal> moviesBox) async {
  serviceLocator
    ..registerLazySingleton<MoviesDatasource>(
      () => MoviesRemoteDatasourceImpl(
        dio: serviceLocator<Dio>(),
      ),
    )
    ..registerLazySingleton<LocalMoviesDatasource>(
      () => MoviesLocalDatasourceImpl(moviesBox: moviesBox),
    )
    ..registerLazySingleton<MoviesRepository>(
      () => MoviesRepositoryImpl(
        moviesDatasource: serviceLocator<MoviesDatasource>(),
        localMoviesDatasource: serviceLocator<LocalMoviesDatasource>(),
        networkInfo: serviceLocator<NetworkInfo>(),
      ),
    )
    ..registerLazySingleton<FutureUseCase<List<Movie>, int>>(
      () => GetPopularMoviesUseCase(
        serviceLocator<MoviesRepository>(),
      ),
    )
    ..registerLazySingleton<FutureUseCase<Movie, String>>(
      () => GetMovieDetailUseCase(
        serviceLocator<MoviesRepository>(),
      ),
    );
}
