import 'package:hive/hive.dart';

part 'movie_local.g.dart';

@HiveType(typeId: 0)
class MovieLocal {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String overview;

  @HiveField(3)
  final String imageUrl;

  @HiveField(4)
  final String backdropPath;

  @HiveField(5)
  final double rating;

  @HiveField(6)
  final double popularity;

  @HiveField(7)
  final String releaseDate;

  @HiveField(8)
  final int page;

  MovieLocal({
    required this.id,
    required this.title,
    required this.overview,
    required this.imageUrl,
    required this.backdropPath,
    required this.rating,
    required this.popularity,
    required this.releaseDate,
    required this.page,
  });
}
