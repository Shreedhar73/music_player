part of 'audio_player_bloc.dart';
abstract class AudioPlayerState extends Equatable{}

class AudioPlayerInitial extends AudioPlayerState{
  @override
  List<Object?> get props => [];
}

class AudioPlayerInitialized extends AudioPlayerState{
  @override
  List<Object?> get props => [];
}


class IsPlayingState extends AudioPlayerState{
  @override
  List<Object?> get props => [];
}

class IsPausedState extends AudioPlayerState{
  @override
  List<Object?> get props => [];
}

// class AudioProgressBarState extends AudioPlayerState{
//   AudioProgressBarState({
//      this.current,
//      this.buffered,
//      this.total,
//   });
//   final Duration? current;
//   final Duration? buffered;
//   final Duration? total;
//   @override
//   List<Object?> get props => [];
// } 