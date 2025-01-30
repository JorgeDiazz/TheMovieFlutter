import 'package:dartz/dartz.dart';
import 'package:the_movie_db/core/errors/failures.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
