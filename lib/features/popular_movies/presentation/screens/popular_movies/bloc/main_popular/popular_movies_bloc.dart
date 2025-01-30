import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_db/core/use_cases/use_cases.dart';
import 'package:the_movie_db/features/popular_movies/domain/entities/movie.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final FutureUseCase<List<Movie>, int> getPopularMoviesUseCase;

  final List<Movie> _movies = [];
  int _page = 0;

  PopularMoviesBloc({required this.getPopularMoviesUseCase})
      : super(PopularMoviesLoading(page: 0)) {
    on<LoadPopularMovies>(_onLoadPopularMovies);
  }

  Future<void> _onLoadPopularMovies(
    LoadPopularMovies event,
    Emitter<PopularMoviesState> emit,
  ) async {
    _page = 1;

    final result = await getPopularMoviesUseCase.call(_page);

    result.fold(
      (failure) =>
          emit(PopularMoviesError(message: failure.message, page: _page)),
      (movies) {
        _movies.addAll(movies);
        emit(PopularMoviesLoaded(movies: _movies, page: _page));
      },
    );
  }
}
