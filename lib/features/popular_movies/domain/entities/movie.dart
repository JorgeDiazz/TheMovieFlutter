class Movie {
  final int id;
  final String title;
  final String imageUrl;
  final String backdropPath;
  final String overview;
  final double rating;
  final DateTime? releaseDate;
  final double popularity;

  Movie({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.backdropPath,
    required this.overview,
    required this.rating,
    required this.releaseDate,
    required this.popularity,
  });
}
