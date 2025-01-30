import 'package:the_movie_db/core/utils/typedefs.dart';
import 'package:the_movie_db/features/popular_movies/domain/entities/movie.dart';

abstract class MoviesRepository {
  ResultFuture<List<Movie>> getPopularMovies({required int page});

  ResultFuture<Movie> getMovieDetail({required String movieId});
}
