import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:the_movie_db/core/service_locator/service_locator.dart';
import 'package:the_movie_db/core/use_cases/use_cases.dart';
import 'package:the_movie_db/features/popular_movies/domain/entities/movie.dart';
import 'package:the_movie_db/features/popular_movies/presentation/screens/movies/bloc/movie_detail_bloc.dart';
import 'package:the_movie_db/features/popular_movies/presentation/screens/movies/bloc/movie_detail_event.dart';
import 'package:the_movie_db/features/popular_movies/presentation/screens/movies/movie_detail_screen.dart';
import 'package:the_movie_db/features/popular_movies/presentation/screens/popular_movies/bloc/main_popular/popular_movies_bloc.dart';
import 'package:the_movie_db/features/popular_movies/presentation/screens/popular_movies/bloc/pagination/more_popular_movies_bloc.dart';
import 'package:the_movie_db/features/popular_movies/presentation/screens/popular_movies/popular_movies_screen.dart';

// GoRouter configuration
final appRouter = GoRouter(
  routes: [
    GoRoute(
        path: '/',
        builder: (context, state) => MultiBlocProvider(
              providers: [
                BlocProvider<PopularMoviesBloc>(
                  create: (context) => PopularMoviesBloc(
                    getPopularMoviesUseCase:
                        serviceLocator<FutureUseCase<List<Movie>, int>>(),
                  )..add(
                      LoadPopularMovies(),
                    ),
                ),
                BlocProvider<MorePopularMoviesBloc>(
                  create: (context) => MorePopularMoviesBloc(
                    getPopularMoviesUseCase:
                        serviceLocator<FutureUseCase<List<Movie>, int>>(),
                  )..add(
                      LoadMorePopularMovies(),
                    ),
                ),
              ],
              child: const PopularMoviesScreen(),
            ),
        routes: [
          GoRoute(
            path: '/:id',
            name: MovieDetailScreen.name,
            builder: (context, state) {
              final movieId = state.pathParameters['id'] ?? 'no-id';

              return BlocProvider(
                  create: (context) => MovieDetailBloc(
                        serviceLocator<FutureUseCase<Movie, String>>(),
                      )..add(
                          LoadMovieDetail(movieId),
                        ),
                  child: MovieDetailScreen(movieId: movieId));
            },
          ),
        ]),
  ],
);
