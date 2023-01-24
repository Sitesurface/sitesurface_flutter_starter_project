import 'package:flutter/material.dart';
import 'common_routes.dart';

class RouteHelper {
  final commonRoutes = CommonRoutes();

  Route<dynamic> getRoutes(RouteSettings settings) {
    Route<dynamic>? route;
    route ??= commonRoutes.generateRoute(settings);
    return route!;
  }
}
