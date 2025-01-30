import 'dart:io';

import 'package:the_movie_db/core/constants/network_constants.dart';

enum FailureCause { noInternetConnection, notFound, unknown }

abstract class Failure {
  Failure({required this.message, this.statusCode = -1});

  final String message;
  final int statusCode;

  FailureCause get cause {
    if (message.contains(NetworkConstants.connectionError)) {
      return FailureCause.noInternetConnection;
    }

    if (statusCode == HttpStatus.notFound) {
      return FailureCause.notFound;
    }

    return FailureCause.unknown;
  }
}

class ServerFailure extends Failure {
  ServerFailure({required super.message, required super.statusCode});
}

class CacheFailure extends Failure {
  CacheFailure({required super.message, super.statusCode});
}
