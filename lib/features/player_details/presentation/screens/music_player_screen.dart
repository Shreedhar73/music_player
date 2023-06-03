import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import '../bloc/audio_player_bloc.dart';
import '../bloc/player_state/player_state_bloc.dart';

@RoutePage()  
class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({super.key, this.songList,this.index=0});
  final List<SongModel?>? songList;
  final int index;

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  late SongModel? currentSong;
  late int currentindex;
  @override
  void initState() {
    currentindex = widget.index;
    currentSong = widget.songList![currentindex];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A091E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A091E),
        foregroundColor: Colors.white,
        title: Text(currentSong!.title,style: const TextStyle(fontSize: 14),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.favorite))
        ],
      ),
      body: SizedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*0.4,
                width: MediaQuery.of(context).size.width,
                child: PageView.builder(
                  itemCount: widget.songList!.length,
                  onPageChanged: (value) {
                    setState(() {
                      if(currentindex < widget.songList!.length){
                        currentindex ++;
                      }else{
                        currentindex = 0;
                      }
                      currentSong = widget.songList![currentindex];
                    });
                  },
                  itemBuilder: (context,idx) {
                    return QueryArtworkWidget(
                      id: currentSong!.id, 
                      type: ArtworkType.AUDIO,
                      artworkQuality: FilterQuality.high,
                      artworkHeight: MediaQuery.of(context).size.height*0.4,
                      errorBuilder: (p0, p1, p2) {
                        return SizedBox(
                          height:  MediaQuery.of(context).size.height*0.4,
                          child: const Center(
                            child: Text('No Album'),
                          ),
                        );
                      },
                      nullArtworkWidget: SizedBox(
                        height:  MediaQuery.of(context).size.height*0.4,
                        child: Center(
                          child: Text('No Thumnail', style: GoogleFonts.mulish(color: Colors.white),),
                        ),
                      ),
                      artworkWidth: MediaQuery.of(context).size.width,
                      quality: 100,
                    );
                  }
                ),
              ),
              const SizedBox(height: 5,),
              Text(
                currentSong!.title,
                style: GoogleFonts.mulish(
                  color: Colors.white,
                  fontSize: 18
                ),
              ),
              Text(
                currentSong!.artist!,
                style: GoogleFonts.mulish(
                  color: const Color(0xFF8E8E8E),
                  fontSize: 16
                ),
              ),
              const SizedBox(height: 100,),
              AudioPlayerWidget(
                song: currentSong,
              )
            ],
          ),
        ),
      ),
    );
  }
}


class AudioPlayerWidget extends StatefulWidget {
  final SongModel? song;
  const AudioPlayerWidget({super.key,this.song});

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AudioPlayerBloc, AudioPlayerState>(
      listener: (context, state) {
        if(state is AudioPlayerInitialized){
          context.read<AudioPlayerBloc>().add(AudioPlayEvent());
        }
      },
      child: BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
          bloc: context.read<AudioPlayerBloc>()..add(AudioPlayerInitializeEvent(songModel: widget.song)),
          builder: (context, state) {
            return SizedBox(
              width: MediaQuery.of(context).size.width*1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BlocListener<PlayerStateBloc, PlayerStateState>(
                    listener: (context, state) {
                      if(state is AudioProgressBarState){
                        if( state.current != Duration.zero && state.current == state.total){
                          context.read<AudioPlayerBloc>().add(AudioPauseEvent());
                          context.read<PlayerStateBloc>().onSeek(Duration.zero);
                        }
                      }
                    },
                    child: BlocBuilder<PlayerStateBloc, PlayerStateState>(
                      bloc: context.read<PlayerStateBloc>()..add(GetPlayerStateEvent()),
                      builder: (context, state) {
                        if(state is AudioProgressBarState){
                          return Padding(
                            padding: const EdgeInsets.only(top: 22),
                            child: Container(
                              height: 50,
                              padding: const EdgeInsets.only(
                                left: 5,
                                top: 5,
                                right: 10,
                                bottom: 30
                              ),
                              child: ProgressBar(
                                progressBarColor: Colors.blue,
                                baseBarColor: Colors.white,
                                thumbColor: Colors.white,
                                thumbRadius: 15,
                                thumbGlowColor: Colors.white.withOpacity(0.5),
                                thumbGlowRadius: 10,
                                timeLabelLocation:
                                    TimeLabelLocation.sides,
                                timeLabelPadding: 0,
                                timeLabelType: TimeLabelType
                                    .remainingTime,
                                timeLabelTextStyle:
                                    const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10),
                                progress: state.current!,
                                buffered: state.buffered!,
                                total: state.total!,
                                onSeek: (Duration duration){
                                  context.read<PlayerStateBloc>().onSeek(duration);
                                },
                              ),
                            ),
                          );
                        }else{
                          return const SizedBox(
                            child: Text('  '),
                          );
                        }
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                        },
                        icon: const Icon(
                          Icons.shuffle,
                          color: Colors.white,
                        )
                      ),
                      IconButton(
                        onPressed: () {
                        },
                        icon: const Icon(
                          Icons.skip_previous_outlined,
                          color: Colors.white,
                        )
                      ),
                      BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
                        builder: (context, state){
                          if(state is IsPausedState){
                            return GestureDetector(
                              onTap: (){
                                  context.read<AudioPlayerBloc>().add(AudioPlayEvent());
                              },
                              child: CircleAvatar(
                                radius: 35,
                                backgroundColor: Colors.blue.withOpacity(0.5),
                                child: const Icon(
                                    Icons.play_arrow_outlined,
                                    size: 45,
                                    color: Colors.white,
                                  )
                              ),
                            );
                          }else{
                            return GestureDetector(
                              onTap: (){
                                context.read<AudioPlayerBloc>().add(AudioPauseEvent());
                              },
                              child: CircleAvatar(
                                radius: 35,
                                backgroundColor: Colors.blue.withOpacity(0.5),
                                child: const Icon(
                                    Icons.pause,
                                    size: 45,
                                    color: Colors.white,
                                  )
                              ),
                            );
                          }
                        },
                      ),
                      IconButton(
                        onPressed: () {
                        },
                        icon: const Icon(
                          Icons.skip_next_outlined,
                          color: Colors.white,
                        )
                      ),
                      IconButton(
                        onPressed: () {
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        )
                      )
                    ],
                  )
                ],
              ),
            );
          },
        ),
    );

  }
}
