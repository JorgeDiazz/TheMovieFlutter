import 'package:the_movie_db/features/popular_movies/domain/entities/movie.dart';
import 'package:the_movie_db/features/popular_movies/infrastructure/models/local/movie_local.dart';
import 'package:the_movie_db/features/popular_movies/infrastructure/models/responses/movies_response.dart';

extension MovieListMapper on List<MovieResponse> {
  List<Movie> toMovieList() =>
      map((movieResponse) => movieResponse.toMovie()).toList();
}

extension MovieMapper on MovieResponse {
  Movie toMovie() => Movie(
        id: id ?? -1,
        title: title ?? '',
        imageUrl: (posterPath?.isEmpty ?? true)
            ? 'https://sd.keepcalms.com/i-w600/keep-calm-poster-not-found.jpg'
            : 'https://image.tmdb.org/t/p/w500$posterPath',
        backdropPath: (backdropPath?.isEmpty ?? true)
            ? 'https://sd.keepcalms.com/i-w600/keep-calm-poster-not-found.jpg'
            : 'https://image.tmdb.org/t/p/w500$backdropPath',
        overview: overview ?? '',
        rating: voteAverage ?? 0.0,
        releaseDate: releaseDate,
        popularity: popularity ?? 0.0,
      );
}

extension LocalToMovie on MovieLocal {
  Movie toMovie() {
    return Movie(
      id: id,
      title: title,
      overview: overview,
      imageUrl: imageUrl,
      backdropPath: backdropPath,
      rating: rating,
      popularity: popularity,
      releaseDate: DateTime.tryParse(releaseDate),
    );
  }
}

extension MovieToLocalMapper on Movie {
  MovieLocal toLocal({required int page}) {
    return MovieLocal(
      id: id,
      title: title,
      overview: overview,
      imageUrl: imageUrl,
      backdropPath: backdropPath,
      rating: rating,
      popularity: popularity,
      releaseDate: releaseDate?.toIso8601String() ?? '',
      page: page,
    );
  }
}
