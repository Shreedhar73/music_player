
part of 'audio_player_bloc.dart';

abstract class AudioPlayerEvent extends Equatable{}

class AudioPlayerInitializeEvent extends AudioPlayEvent{
  final SongModel? songModel;
  AudioPlayerInitializeEvent({this.songModel});
  @override
  List<Object?> get props => [];
}

class AudioPlayEvent extends AudioPlayerEvent{
  @override
  List<Object?> get props => [];
}

class AudioPauseEvent extends AudioPlayerEvent{
  @override
  List<Object?> get props => [];
}

class AudioPlayerDisposeEvent extends AudioPlayerEvent{
  @override
  List<Object?> get props => [];
}