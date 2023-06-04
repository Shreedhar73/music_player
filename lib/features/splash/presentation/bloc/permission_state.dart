part of 'permission_bloc.dart';

abstract class PermissionState extends Equatable{}


class PermissionStateInitial extends PermissionState{
  @override
  List<Object?> get props => [];

}

class PermissionFailure extends PermissionState{
  @override
  List<Object?> get props => [];
}

class PermissionGrantedState extends PermissionState{
  @override
  List<Object?> get props => [];
}

class PermissionPermanentlyDeniedState extends PermissionState{
  @override
  List<Object?> get props => [];
}

class PermissionRestrictedState extends PermissionState{
  @override
  List<Object?> get props => [];
}