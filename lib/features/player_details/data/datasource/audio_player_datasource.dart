import 'dart:async';

import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../models/button_state.dart';
import '../models/progressbar_state_model.dart';

abstract class AudioPlayerDataSource{
  Future<dynamic> initializeAudioPlayer({SongModel? song, String? artWork});
  Future<dynamic> play();
  Future<dynamic> pause();
  Future<dynamic> disposeAudioPlayer();
  Future<dynamic> getPlayerState();
  Future<dynamic> onSeek(Duration duration);
}

class AudioPlayerDataSourceImpl implements AudioPlayerDataSource{
  AudioPlayerDataSourceImpl();
  SongModel? currentPlaying;
  ProgressBarState progressBarState = const ProgressBarState(
    current: Duration.zero, 
    buffered: Duration.zero, 
    total: Duration.zero
  );
  ButtonState buttonState = ButtonState.paused;

  AudioPlayer? audioPlayer;
  
  @override
  Future disposeAudioPlayer() async{
    audioPlayer!.stop();
    audioPlayer!.dispose();
    return true;
  }
  
  @override
  Future initializeAudioPlayer({SongModel? song, String? artWork = ''}) async{
    if(audioPlayer != null){
      audioPlayer!.dispose();
      audioPlayer!.stop();
    }
    audioPlayer = AudioPlayer();
    try{
      await audioPlayer!.setAudioSource(
        AudioSource.file (
          song!.data ,
          tag: MediaItem(
            id: song.id.toString(), 
            title: song.displayName,
            artUri: Uri.parse(artWork!)
          )
        )
      );
      audioPlayer!.playerStateStream.listen((playerState) {
        final isPlaying = playerState.playing;
        final processingState = playerState.processingState;
        if (processingState == ProcessingState.loading ||
            processingState == ProcessingState.buffering) {
          buttonState = ButtonState.loading;
        } else if (!isPlaying) {
          buttonState = ButtonState.paused;
        } else if (processingState != ProcessingState.completed) {
          buttonState = ButtonState.playing;
        } else {
          audioPlayer!.seek(Duration.zero);
          audioPlayer!.pause();
        }
      });

    audioPlayer!.positionStream.listen((position) {
      final oldState = progressBarState;
      progressBarState = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });

    audioPlayer!.bufferedPositionStream.listen((bufferedPosition) {
      final oldState = progressBarState;
      progressBarState = ProgressBarState(
        current: oldState.current,
        buffered: bufferedPosition,
        total: oldState.total,
      );
    });

    audioPlayer!.durationStream.listen((totalDuration) {
      final oldState = progressBarState;
      progressBarState = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: totalDuration ?? Duration.zero,
      );
    });
    }catch(e){
      throw UnimplementedError();
    }
  }
  
  @override
  Future pause() async{
    audioPlayer!.pause();
    return true;
  }
  
  @override
  Future play() async{
    if(audioPlayer != null){
      audioPlayer!.play();
    }
  }

  @override
  Future onSeek(Duration duration) async{
    audioPlayer!.seek(duration);
    return true;
  }
  
  @override
  Future getPlayerState() async{
    StreamController<ProgressBarState> controller = StreamController<ProgressBarState>();
    Stream progressStream = controller.stream;
    audioPlayer!.positionStream.listen((position) {
      final oldState = progressBarState;
      progressBarState = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
      controller.add(progressBarState);
      
    });

    audioPlayer!.bufferedPositionStream.listen((bufferedPosition) {
      final oldState = progressBarState;
      progressBarState = ProgressBarState(
        current: oldState.current,
        buffered: bufferedPosition,
        total: oldState.total,
      );
      controller.add(progressBarState);
    });

    audioPlayer!.durationStream.listen((totalDuration) {
      final oldState = progressBarState;
      progressBarState = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: totalDuration ?? Duration.zero,
      );
      controller.add(progressBarState);
    });
    
    return progressStream;

  }
}