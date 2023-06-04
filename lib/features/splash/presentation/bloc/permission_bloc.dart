import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/app/core/usecases/usecases.dart';
import 'package:music_player/features/splash/domain/usecases/permission_status_usecase.dart';

part 'permission_events.dart';
part 'permission_state.dart';

class PermissionBloc extends Bloc<PermissionEvents,PermissionState>{
  final PermissionStatusUseCase permissionUseCase;

  PermissionBloc(
    { required this.permissionUseCase}) 
    : super (PermissionStateInitial()){
      on<GetPermission>(_getPermission);
    }
  
  FutureOr<void> _getPermission(GetPermission event, Emitter<PermissionState> emit) async{
    emit(PermissionStateInitial());
    final results = await permissionUseCase.call(NoParams());
    results.fold((l) => emit(PermissionFailure()), 
    (results) {
      if(results.isGranted){
        return emit(PermissionGrantedState());
      }else if(results.isPermanentlyDenied){
        return emit(PermissionPermanentlyDeniedState());
      }else{
        return emit(PermissionRestrictedState());
      }
    }
    
    );
  }
}