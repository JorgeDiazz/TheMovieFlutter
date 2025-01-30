part of 'more_popular_movies_bloc.dart';

abstract class MorePopularMoviesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadMorePopularMovies extends MorePopularMoviesEvent {}
