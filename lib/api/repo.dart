class Repo {
  /// Create map and return only those fields that are not null
  Map<String, dynamic> _removeNull(dynamic object) {
    Map<String, dynamic> map = {};
    map.addAll(object.toJson());
    map.removeWhere((key, value) => value == null);
    return map;
  }

  /// Example of repository function
  // Future<dynamic> getConstant() async {
  //   return await ApiHelper.get("/api/settings");
  // }

}
