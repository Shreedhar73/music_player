
import 'package:music_player/features/splash/domain/entities/permission_entity.dart';

class PermissionStatusModel extends PermissionStatusEntity{
  const PermissionStatusModel({
    required isGranted,
    required isPermanentlyDenied,
    required isRestricted
  }) : super(
    isGranted: isGranted,
    isPermanentlyDenied: isPermanentlyDenied,
    isRestricted: isRestricted
  );
 
  factory PermissionStatusModel.fromJson(Map<String, dynamic> json) => PermissionStatusModel(
    isGranted: json['isGranted'],
    isPermanentlyDenied: json['isPermanentlyDenied'],
    isRestricted: json['isRestricted'],
  );
  
}