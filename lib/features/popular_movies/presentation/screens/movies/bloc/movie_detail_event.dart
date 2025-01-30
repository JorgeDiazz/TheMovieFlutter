import 'package:equatable/equatable.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadMovieDetail extends MovieDetailEvent {
  final String movieId;

  const LoadMovieDetail(this.movieId);

  @override
  List<Object> get props => [movieId];
}
