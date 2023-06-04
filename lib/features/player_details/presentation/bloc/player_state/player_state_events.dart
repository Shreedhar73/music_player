part of 'player_state_bloc.dart';



abstract class PlayerStateEvent extends Equatable{}


class GetPlayerStateEvent extends PlayerStateEvent{
  @override
  List<Object?> get props => [];
}