import 'package:dartz/dartz.dart';
import 'package:the_movie_db/core/errors/exceptions.dart';
import 'package:the_movie_db/core/errors/failures.dart';
import 'package:the_movie_db/core/utils/typedefs.dart';
import 'package:the_movie_db/features/popular_movies/domain/entities/movie.dart';
import 'package:the_movie_db/features/popular_movies/domain/repositories/movies_repository.dart';
import 'package:the_movie_db/features/popular_movies/infrastructure/datasources/movies_local_datasource.dart';
import 'package:the_movie_db/features/popular_movies/infrastructure/datasources/movies_datasource.dart';
import 'package:the_movie_db/features/popular_movies/infrastructure/mappers/movie_mapper.dart';
import 'package:the_movie_db/core/utils/network_info.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final MoviesDatasource moviesDatasource;
  final LocalMoviesDatasource localMoviesDatasource;
  final NetworkInfo networkInfo;

  MoviesRepositoryImpl({
    required this.moviesDatasource,
    required this.localMoviesDatasource,
    required this.networkInfo,
  });

  @override
  ResultFuture<List<Movie>> getPopularMovies({required int page}) async {
    if (await networkInfo.isConnected) {
      try {
        final popularMoviesResponse =
            await moviesDatasource.getPopularMovies(page: page);
        final movies = popularMoviesResponse.toMovieList();

        // Cache movies in local database
        await localMoviesDatasource.cacheMovies(movies, page);

        return Right(movies);
      } on ServerException catch (e) {
        return Left(
            ServerFailure(message: e.message, statusCode: e.statusCode));
      }
    }
    // Return cached movies if offline
    try {
      final cachedMovies =
          await localMoviesDatasource.getCachedMovies(page: page);
      return Right(cachedMovies);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  ResultFuture<Movie> getMovieDetail({required String movieId}) async {
    try {
      final movieDetailResponse =
          await moviesDatasource.getMovieDetail(movieId: movieId);
      return Right(movieDetailResponse.toMovie());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
