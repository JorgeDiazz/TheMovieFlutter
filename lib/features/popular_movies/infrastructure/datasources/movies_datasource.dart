import 'package:the_movie_db/features/popular_movies/infrastructure/models/responses/movies_response.dart';

abstract class MoviesDatasource {
  Future<List<MovieResponse>> getPopularMovies({required int page});

  Future<MovieResponse> getMovieDetail({required String movieId});
}
