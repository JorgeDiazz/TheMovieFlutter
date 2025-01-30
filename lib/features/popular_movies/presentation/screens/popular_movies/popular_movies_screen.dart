import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_db/features/popular_movies/presentation/screens/popular_movies/bloc/pagination/more_popular_movies_bloc.dart';
import 'package:the_movie_db/features/popular_movies/presentation/screens/popular_movies/bloc/main_popular/popular_movies_bloc.dart';
import 'package:the_movie_db/features/popular_movies/presentation/widgets/movie_masonry.dart';
import 'package:the_movie_db/features/popular_movies/presentation/widgets/movies_slideshow.dart';
import 'package:the_movie_db/features/popular_movies/presentation/widgets/shared/custom_appbar.dart';

class PopularMoviesScreen extends StatelessWidget {
  const PopularMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const ScrollPhysics(),
        slivers: [
          const SliverAppBar(
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: CustomAppbar(),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Column(
                  children: [
                    // BlocBuilder for MoviesSlideshow
                    BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
                      builder: (context, state) {
                        if (state is PopularMoviesLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is PopularMoviesLoaded) {
                          return MoviesSlideshow(
                              movies: state.movies.sublist(0, 3));
                        } else if (state is PopularMoviesError) {
                          return Center(child: Text(state.message));
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    // BlocBuilder for MorePopularMoviesBloc (for MovieMasonry)
                    BlocBuilder<MorePopularMoviesBloc, MorePopularMoviesState>(
                      builder: (context, state) {
                        if (state is MorePopularMoviesLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is MorePopularMoviesLoaded) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: MovieMasonry(
                              movies: state.movies,
                              loadNextPage: () => context
                                  .read<MorePopularMoviesBloc>()
                                  .add(LoadMorePopularMovies()),
                            ),
                          );
                        } else if (state is MorePopularMoviesError) {
                          return Center(child: Text(state.message));
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
