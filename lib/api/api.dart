// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:http/http.dart' as http;
import '../flavors/config/build_flavor.dart';
import '../helpers/handlers/locale_handler.dart';
import '../helpers/packages/package_info_helper.dart';
import '../cache/shared_preferences.dart';
import '../flavors/config/flavor_config.dart';
import '../util/bot_toast/bot_toast_functions.dart';
import 'exception/api_exception.dart';
import 'exception/auth_exception.dart';
import 'exception/server_exception.dart';

/// This class is used to handle the http calls.
/// It will make the http call and return the response to response handler.
class ApiHelper {
  static final String? _baseUrl = FlavorConfig.instance.baseUrl;
  static final _pref = Pref.instance.pref;

  /// Function used for getting header for the http call.
  static Future<Map<String, String>?> getHeader() async {
    var token = await FirebaseAuth.instance.currentUser?.getIdToken();

    if (token != null) {
      _pref.setString("token", token);
    }
    Map<String, String>? header = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
      "X-Platform": Platform.operatingSystem,
      "X-App-Version": PackageInfoHelper.instance.packageInfo.version,
      "X-Environment": FlavorConfig.instance.buildFlavor.toString(),
      "X-Locale": LocaleHandler.getLocale().toLanguageTag(),
    };
    if (BuildFlavor.prod == FlavorConfig.instance.buildFlavor) {
      var firebaseToken = (await FirebaseAppCheck.instance.getToken()) ?? "";
      header.addAll({"X-App-Check": firebaseToken});
    }
    return header;
  }

  /// Function to make get request to the [endpoint] with [queryParams].
  static Future<dynamic> get(String endpoint,
      {Map<String, String>? queryParams}) async {
    var responseJson;

    try {
      Map<String, String>? header;
      header = await getHeader();
      final response = await http.get(
        Uri.parse('$_baseUrl$endpoint').replace(
          queryParameters: queryParams,
        ),
        headers: header,
      );

      responseJson = _returnResponse(response);
    } on SocketException {
      throw Exception('No Internet connection');
    }
    return responseJson;
  }

  /// Function to make post request to the [endpoint] with [data] and [queryParams].
  static Future<dynamic> post(String endpoint, dynamic data,
      {Map<String, String>? queryParams}) async {
    var responseJson;
    try {
      Map<String, String>? header;
      header = await getHeader();

      final response = await http.post(
        Uri.parse('$_baseUrl$endpoint').replace(
          queryParameters: queryParams,
        ),
        body: jsonEncode(data),
        headers: header,
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw Exception('No Internet connection');
    }
    return responseJson;
  }

  /// Function to make put request to the [endpoint] with [data] .
  static Future<dynamic> put(
    String endpoint,
    dynamic data,
  ) async {
    var responseJson;
    try {
      Map<String, String>? header;
      header = await getHeader();
      final response = await http.put(
        Uri.parse('$_baseUrl$endpoint'),
        body: jsonEncode(data),
        headers: header,
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw Exception('No Internet connection');
    }
    return responseJson;
  }

  /// Function to make patch request to the [endpoint] with [data] and [queryParams].
  static Future<dynamic> patch(String endpoint, dynamic data,
      {Map<String, String>? queryParams}) async {
    var responseJson;
    dynamic response;
    try {
      Map<String, String>? header;
      header = await getHeader();

      response = await http.patch(
          Uri.parse('$_baseUrl$endpoint').replace(queryParameters: queryParams),
          body: jsonEncode(data),
          headers: header);

      responseJson = _returnResponse(response);
    } on SocketException {
      throw Exception('No Internet connection');
    }
    return responseJson;
  }

  /// Function to make delete request to the [endpoint] with [data] and [queryParams].
  static Future<dynamic> delete(String endpoint, dynamic data,
      {Map<String, String>? queryParams}) async {
    var responseJson;
    try {
      Map<String, String>? header;
      header = await getHeader();
      final response = await http.delete(
        Uri.parse('$_baseUrl$endpoint').replace(
          queryParameters: queryParams,
        ),
        body: jsonEncode(data),
        headers: header,
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw Exception('No Internet connection');
    }
    return responseJson;
  }

  /// Function to return the appropriate response according to the status code.
  static dynamic _returnResponse(dynamic response) async {
    try {
      switch (response.statusCode) {
        case 200:
        case 201:
          return jsonDecode(response.body);
        case 401:
          throw AuthException(code: "unauthorized-access");
        case 400:
          String code = jsonDecode(response.body)['errors'][0];
          throw ApiException(code: code);
        case 422:
          String code = jsonDecode(response.body)['message'];
          throw ApiException(code: code);
        case 500 - 599:
          throw ServerException(
              code: "server-error", message: "Internal Server Error");
        default:
          throw ('Error occured while Communication with Server with StatusCode : ${response.statusCode}');
      }
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  static void _handleError(dynamic e) {
    if (e is AuthException) {
      showNotification(title: 'Unauthorized Access');
    } else if (e is ApiException) {
      showNotification(title: e.code);
    } else if (e is ServerException) {
      showNotification(title: 'Internal Server Error');
    } else {
      showNotification(title: 'Error occured while Communication with Server');
    }
  }
}
