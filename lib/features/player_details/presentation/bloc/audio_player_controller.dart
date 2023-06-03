

import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PageManagerController{
  // PageManagerController({required this.song,this.artWork});
  PageManagerController._();
  static final _instance = PageManagerController._(
  );
  static PageManagerController get instance => _instance;
  // final SongModel? song;
  // final String? artWork;
  
  var isVisible = false;
  var isPlaying = false;
  var songTitle = '';
  SongModel? currentPlaying;
  ValueNotifier<ProgressBarState>? progressNotifier = ValueNotifier<ProgressBarState>(
    ProgressBarState(
      current: Duration.zero,
      buffered: Duration.zero,
      total: Duration.zero,
    ),
  );
  ValueNotifier<ButtonState>? buttonNotifier = ValueNotifier<ButtonState>(ButtonState.paused);

  AudioPlayer? audioPlayer;
  void init({SongModel? song, String? artWork = ''}) async {
    currentPlaying = song!;
    audioPlayer = AudioPlayer();
    try {
      await audioPlayer!.setAudioSource(
        AudioSource.file (
          song.data ,
          tag: MediaItem(
            id: song.id.toString(), 
            title: song.displayName,
            artUri: Uri.parse(artWork!)
          )
        )
      );
    }catch(e){
        if (kDebugMode) {
          print(e);
      }
    }
    
    audioPlayer!.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        buttonNotifier!.value = ButtonState.loading;
      } else if (!isPlaying) {
        buttonNotifier!.value = ButtonState.paused;
      } else if (processingState != ProcessingState.completed) {
        buttonNotifier!.value = ButtonState.playing;
      } else {
        audioPlayer!.seek(Duration.zero);
        audioPlayer!.pause();
      }
    });

    audioPlayer!.positionStream.listen((position) {
      final oldState = progressNotifier?.value;
      progressNotifier?.value = ProgressBarState(
        current: position,
        buffered: oldState!.buffered,
        total: oldState.total,
      );
    });

    audioPlayer!.bufferedPositionStream.listen((bufferedPosition) {
      final oldState = progressNotifier?.value;
      progressNotifier?.value = ProgressBarState(
        current: oldState!.current,
        buffered: bufferedPosition,
        total: oldState.total,
      );
    });

    audioPlayer!.durationStream.listen((totalDuration) {
      final oldState = progressNotifier?.value;
      progressNotifier?.value = ProgressBarState(
        current: oldState!.current,
        buffered: oldState.buffered,
        total: totalDuration ?? Duration.zero,
      );
    });
  }

  void play() {
    // init();
   Future.delayed(Duration.zero,(() => audioPlayer!.play()));
   
  }

  void pause() {
    audioPlayer!.pause();
    
  }

  void seek(Duration position) {
    audioPlayer!.seek(position);
  }


  void setSpeed(double speed){
    audioPlayer!.setSpeed(speed);
  }

  disposePlayer(){
    // currentPlaying = null;
    // progressNotifier = null;
    // buttonNotifier = null;
    audioPlayer!.stop();
    audioPlayer!.dispose();
  }
  
  
}

class ProgressBarState {
  ProgressBarState({
    required this.current,
    required this.buffered,
    required this.total,
  });
  final Duration current;
  final Duration buffered;
  final Duration total;
}

enum ButtonState { paused, playing, loading }


