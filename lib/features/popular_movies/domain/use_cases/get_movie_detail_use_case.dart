import 'package:the_movie_db/core/use_cases/use_cases.dart';
import 'package:the_movie_db/core/utils/typedefs.dart';
import 'package:the_movie_db/features/popular_movies/domain/entities/movie.dart';
import 'package:the_movie_db/features/popular_movies/domain/repositories/movies_repository.dart';

class GetMovieDetailUseCase implements FutureUseCase<Movie, String> {
  final MoviesRepository repository;

  GetMovieDetailUseCase(this.repository);

  @override
  ResultFuture<Movie> call(String input) async {
    return await repository.getMovieDetail(movieId: input);
  }
}
