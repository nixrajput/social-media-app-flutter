import 'package:social_media_app/constants/enums.dart';

class RouteService {
  factory RouteService() {
    return _instance;
  }

  RouteService._internal();

  static RouteStatus routeStatus = RouteStatus.init;

  static final RouteService _instance = RouteService._internal();

  static set(RouteStatus status) {
    routeStatus = status;
  }
}
