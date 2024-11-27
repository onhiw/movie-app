class ServerException implements Exception {
  ServerException();
}

class DatabaseException implements Exception {
  final String message;

  DatabaseException(this.message);
}
