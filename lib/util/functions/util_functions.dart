class UtilFunc {
  static T? tryParse<T>(
      T Function(Map<String, dynamic>) parser, Map<String, dynamic> data) {
    try {
      return parser(data);
    } catch (e) {
      return null;
    }
  }
}
