import 'package:flutter/material.dart';
import 'package:sitesurface_flutter_starter_project/routes/common_routes.dart';

class RouteHelper {
  final commonRoutes = CommonRoutes();

  Route<dynamic> getRoutes(RouteSettings settings) {
    Route<dynamic>? route;
    route ??= commonRoutes.generateRoute(settings);
    return route!;
  }
}
