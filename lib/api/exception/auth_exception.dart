class AuthException implements Exception {
  String code;
  AuthException({required this.code});
}
