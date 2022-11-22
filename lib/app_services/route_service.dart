import 'package:social_media_app/constants/enums.dart';

class RouteService {
  static final RouteService _instance = RouteService._internal();

  RouteService._internal();

  factory RouteService() {
    return _instance;
  }

  static RouteStatus routeStatus = RouteStatus.init;

  static set(RouteStatus status) {
    routeStatus = status;
  }
}
