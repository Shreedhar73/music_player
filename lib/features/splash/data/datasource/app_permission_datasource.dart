

import 'package:music_player/features/splash/data/models/permission_model.dart';
import 'package:on_audio_query/on_audio_query.dart';
// import 'package:permission_handler/permission_handler.dart';

abstract class AppPermissionDataSource{

  Future<PermissionStatusModel> askForPermission();
}

class AppPermissionDataSourceImpl extends AppPermissionDataSource {
  @override
  Future<PermissionStatusModel> askForPermission() async{
    var status =  await OnAudioQuery().checkAndRequest(retryRequest: true);
    return PermissionStatusModel(
      isGranted: status,
      isPermanentlyDenied : !status,
      isRestricted: !status
    );
  }

}