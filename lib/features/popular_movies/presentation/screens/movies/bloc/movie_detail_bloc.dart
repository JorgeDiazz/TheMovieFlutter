import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_db/core/use_cases/use_cases.dart';
import 'package:the_movie_db/features/popular_movies/domain/entities/movie.dart';
import 'package:the_movie_db/features/popular_movies/presentation/screens/movies/bloc/movie_detail_event.dart';
import 'package:the_movie_db/features/popular_movies/presentation/screens/movies/bloc/movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final FutureUseCase<Movie, String> getMovieDetailUseCase;

  MovieDetailBloc(this.getMovieDetailUseCase) : super(MovieDetailInitial()) {
    on<LoadMovieDetail>((event, emit) async {
      emit(MovieDetailLoading());
      final result = await getMovieDetailUseCase(event.movieId);
      result.fold(
        (failure) => emit(MovieDetailError(failure.message)),
        (movie) => emit(MovieDetailLoaded(movie)),
      );
    });
  }
}
