import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:the_movie_db/core/config/l10n/l10n.dart';
import 'package:the_movie_db/features/popular_movies/domain/entities/movie.dart';

class MoviesSlideshow extends StatelessWidget {
  final List<Movie> movies;
  final int limit;

  const MoviesSlideshow({super.key, required this.movies, this.limit = 3});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      children: [
        _buildHeader(context, colors),
        SizedBox(
          height: 10,
        ),
        _buildSlideShow(context, colors),
      ],
    );
  }

  Widget _buildSlideShow(BuildContext context, ColorScheme colors) {
    return SizedBox(
      height: 310,
      width: double.infinity,
      child: Swiper(
        viewportFraction: 0.8,
        scale: 0.9,
        autoplay: true,
        pagination: SwiperPagination(
          margin: const EdgeInsets.only(top: 0),
          builder: DotSwiperPaginationBuilder(
            activeColor: colors.primary,
            color: colors.secondary,
          ),
        ),
        itemCount: limit,
        itemBuilder: (context, index) => _Slide(movie: movies[index]),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ColorScheme colors) {
    return _Title(S.of(context).top_n_popular_movies_title(limit.toString()));
  }
}

class _Title extends StatelessWidget {
  final String title;

  const _Title(this.title);

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context)
        .textTheme
        .titleLarge
        ?.copyWith(color: Theme.of(context).colorScheme.primary);

    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: Text(title, style: titleStyle),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;

  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
              color: Colors.black45, blurRadius: 10, offset: Offset(0, 10))
        ]);

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: GestureDetector(
            onTap: () => context.push('/${movie.id}'),
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: movie.imageUrl,
              placeholder: (context, url) =>
                  Image.asset('assets/loaders/dual_ball_loader.gif'),
            ),
          ),
        ),
      ),
    );
  }
}
