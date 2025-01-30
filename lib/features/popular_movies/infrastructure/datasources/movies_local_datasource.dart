import 'package:the_movie_db/features/popular_movies/domain/entities/movie.dart';

abstract class LocalMoviesDatasource {
  Future<List<Movie>> getCachedMovies({required int page});

  Future<void> cacheMovies(List<Movie> movies, int page);
}
