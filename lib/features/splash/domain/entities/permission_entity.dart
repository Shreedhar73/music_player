import 'package:equatable/equatable.dart';

class PermissionStatusEntity extends Equatable{
  final bool isGranted;
  final bool isPermanentlyDenied;
  final bool isRestricted;

  const PermissionStatusEntity({
    required this.isGranted,
    required this.isPermanentlyDenied,
    required this.isRestricted
  });
  @override
  List<Object?> get props => [isGranted, isPermanentlyDenied,isRestricted];
}