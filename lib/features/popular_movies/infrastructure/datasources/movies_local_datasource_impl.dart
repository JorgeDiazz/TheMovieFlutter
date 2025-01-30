import 'package:hive/hive.dart';
import 'package:the_movie_db/core/errors/exceptions.dart';
import 'package:the_movie_db/features/popular_movies/domain/entities/movie.dart';
import 'package:the_movie_db/features/popular_movies/infrastructure/datasources/movies_local_datasource.dart';
import 'package:the_movie_db/features/popular_movies/infrastructure/mappers/movie_mapper.dart';
import 'package:the_movie_db/features/popular_movies/infrastructure/models/local/movie_local.dart';

class MoviesLocalDatasourceImpl implements LocalMoviesDatasource {
  final Box<MovieLocal> moviesBox;

  MoviesLocalDatasourceImpl({required this.moviesBox});

  @override
  Future<List<Movie>> getCachedMovies({required int page}) async {
    final cachedMovies =
        moviesBox.values.where((movie) => movie.page == page).toList();

    if (cachedMovies.isEmpty) {
      throw CacheException(message: 'No cached movies found');
    }

    return cachedMovies.map((model) => model.toMovie()).toList();
  }

  @override
  Future<void> cacheMovies(List<Movie> movies, int page) async {
    // Clear previous cache for this page
    final keysToDelete = moviesBox.values
        .where((movie) => movie.page == page)
        .map((movie) => movie.id)
        .toList();

    await moviesBox.deleteAll(keysToDelete);

    // Cache new movies
    final movieModels =
        movies.map((movie) => movie.toLocal(page: page)).toList();

    await moviesBox.addAll(movieModels);
  }
}
