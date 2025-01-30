part of 'popular_movies_bloc.dart';

abstract class PopularMoviesState extends Equatable {
  final int page;

  const PopularMoviesState({required this.page});

  @override
  List<Object?> get props => [];
}

// Popular movies
class PopularMoviesLoading extends PopularMoviesState {
  const PopularMoviesLoading({required super.page});
}

class PopularMoviesLoaded extends PopularMoviesState {
  final List<Movie> movies;

  const PopularMoviesLoaded({required this.movies, required super.page});

  @override
  List<Object?> get props => [movies, page];
}

class PopularMoviesError extends PopularMoviesState {
  final String message;

  const PopularMoviesError({required this.message, required super.page});

  @override
  List<Object?> get props => [message];
}
