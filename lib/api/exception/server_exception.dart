class ServerException implements Exception {
  String code;
  String message;
  ServerException({
    required this.code,
    required this.message,
  });
}
