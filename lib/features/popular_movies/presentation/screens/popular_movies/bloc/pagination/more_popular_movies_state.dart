part of 'more_popular_movies_bloc.dart';

abstract class MorePopularMoviesState extends Equatable {
  final int page;

  const MorePopularMoviesState({required this.page});

  @override
  List<Object?> get props => [];
}

// More popular movies
class MorePopularMoviesLoading extends MorePopularMoviesState {
  const MorePopularMoviesLoading({required super.page});
}

class MorePopularMoviesLoaded extends MorePopularMoviesState {
  final List<Movie> movies;

  const MorePopularMoviesLoaded({required this.movies, required super.page});

  @override
  List<Object?> get props => [movies, page];
}

class MorePopularMoviesError extends MorePopularMoviesState {
  final String message;

  const MorePopularMoviesError({required this.message, required super.page});

  @override
  List<Object?> get props => [message];
}
