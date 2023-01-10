class ApiException implements Exception {
  String code;
  ApiException({required this.code});
}
