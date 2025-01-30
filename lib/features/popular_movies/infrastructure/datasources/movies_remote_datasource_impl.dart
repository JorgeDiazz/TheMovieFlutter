import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:the_movie_db/core/constants/network_constants.dart';
import 'package:the_movie_db/core/errors/exceptions.dart';
import 'package:the_movie_db/features/popular_movies/infrastructure/datasources/movies_datasource.dart';
import 'package:the_movie_db/features/popular_movies/infrastructure/models/responses/movies_response.dart';

class MoviesRemoteDatasourceImpl implements MoviesDatasource {
  MoviesRemoteDatasourceImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<List<MovieResponse>> getPopularMovies({required int page}) async {
    try {
      final response = await _dio.get(NetworkConstants.popularMoviesEndpoint);
      return MoviesResponse.fromJson(response.data).results ?? [];
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);

      throw ServerException(
        message: e.toString(),
        statusCode: HttpStatus.httpVersionNotSupported,
      );
    }
  }

  @override
  Future<MovieResponse> getMovieDetail({required String movieId}) async {
    try {
      final response =
          await _dio.get('${NetworkConstants.findByIdEndpoint}/$movieId');
      return MovieResponse.fromJson(response.data);
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);

      throw ServerException(
        message: e.toString(),
        statusCode: HttpStatus.httpVersionNotSupported,
      );
    }
  }
}
