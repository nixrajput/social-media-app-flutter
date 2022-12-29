import 'package:social_media_app/app_services/network_controller.dart';
import 'package:social_media_app/utils/utility.dart';
import 'package:workmanager/workmanager.dart';

const backgroundMessageTask = "backgroundMessageTask";
const backgroundNotificationTask = "backgroundNotificationTask";

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case backgroundMessageTask:
        final networkService = NetworkController.instance;
        if (!networkService.isInitialized) {
          await networkService.init();
        }
        if (networkService.isConnected) {
          AppUtility.log('Network is connected');
        }
        AppUtility.log('Background Message Task');
        break;
      case backgroundNotificationTask:
        AppUtility.log('Background Notification Task');
        break;
      case Workmanager.iOSBackgroundTask:
        AppUtility.log('iOS Background Task');
        break;
    }
    return Future.value(true);
  });
}
