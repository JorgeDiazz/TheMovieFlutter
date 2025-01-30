import 'package:the_movie_db/core/use_cases/use_cases.dart';
import 'package:the_movie_db/core/utils/typedefs.dart';
import 'package:the_movie_db/features/popular_movies/domain/entities/movie.dart';
import 'package:the_movie_db/features/popular_movies/domain/repositories/movies_repository.dart';

class GetPopularMoviesUseCase extends FutureUseCase<List<Movie>, int> {
  GetPopularMoviesUseCase(this._moviesRepository);

  final MoviesRepository _moviesRepository;

  @override
  ResultFuture<List<Movie>> call(int input) {
    return _moviesRepository.getPopularMovies(page: input);
  }
}
