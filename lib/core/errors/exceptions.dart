class ServerException implements Exception {
  const ServerException({required this.message, required this.statusCode});

  final String message;
  final int statusCode;
}

class CacheException implements Exception {
  final String message;

  const CacheException({required this.message});

  @override
  String toString() => message;
}
