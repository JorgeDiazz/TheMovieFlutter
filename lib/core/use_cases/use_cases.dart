import 'package:the_movie_db/core/utils/typedefs.dart';

abstract class UseCase<T, R> {
  const UseCase();

  T call(R input);
}

abstract class FutureUseCase<T, R> {
  const FutureUseCase();

  ResultFuture<T> call(R input);
}
