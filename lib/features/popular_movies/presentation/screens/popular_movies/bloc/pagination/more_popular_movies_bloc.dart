import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_db/core/use_cases/use_cases.dart';
import 'package:the_movie_db/features/popular_movies/domain/entities/movie.dart';

part 'more_popular_movies_event.dart';
part 'more_popular_movies_state.dart';

class MorePopularMoviesBloc
    extends Bloc<MorePopularMoviesEvent, MorePopularMoviesState> {
  final FutureUseCase<List<Movie>, int> getPopularMoviesUseCase;

  final List<Movie> _movies = [];

  MorePopularMoviesBloc({required this.getPopularMoviesUseCase})
      : super(MorePopularMoviesLoading(page: 0)) {
    on<LoadMorePopularMovies>(_onLoadMorePopularMovies);
  }

  void _onLoadMorePopularMovies(
    LoadMorePopularMovies event,
    Emitter<MorePopularMoviesState> emit,
  ) async {
    final page = state.page + 1;

    final result = await getPopularMoviesUseCase.call(page);

    result.fold(
      (failure) =>
          emit(MorePopularMoviesError(message: failure.message, page: page)),
      (newMovies) {
        _movies.addAll(newMovies);
        emit(MorePopularMoviesLoaded(movies: _movies, page: page));
      },
    );
  }
}
