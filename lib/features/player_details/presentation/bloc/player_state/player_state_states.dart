part of 'player_state_bloc.dart';

abstract class PlayerStateState extends Equatable{}


class PlayerStateInitial extends PlayerStateState{
  @override
  List<Object?> get props => [];
}
class AudioProgressBarState extends PlayerStateState{
  AudioProgressBarState({
     this.current,
     this.buffered,
     this.total,
  });
  final Duration? current;
  final Duration? buffered;
  final Duration? total;
  @override
  List<Object?> get props => [];
} 