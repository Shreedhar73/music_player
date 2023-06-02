import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height*0.4,
              width: MediaQuery.of(context).size.width,
              child: PageView.builder(
                itemCount: widget.songList!.length,
                onPageChanged: (value) {
                  setState(() {
                    currentindex = value;
                    currentSong = widget.songList![value];
                  });
                  disposePlayer();
                  initializePlayerController(currentSong!.data);
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

            AudioPlayerWidget(url: currentSong!.data)
          ],
        ),
      ),
    );
  }
}

late AudioPlayer _player;
initializePlayerController(String filePath){
  _player = AudioPlayer(
  );
  _player.setAudioSource(
    AudioSource.file(filePath)
  );
  _player.play();
}

disposePlayer(){
  _player.pause();
  _player.dispose();
}


class AudioPlayerWidget extends StatefulWidget {
  final String url;
  const AudioPlayerWidget({super.key, required this.url});

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {

  @override
  void initState() {
    super.initState();
    initializePlayerController(widget.url);
  }

  @override
  void dispose() {
    disposePlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: _player.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;

        return Column(
          children: [
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering)
              const CircularProgressIndicator(),
            if (processingState != ProcessingState.loading)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (processingState != ProcessingState.completed)
                    IconButton(
                      icon:  _player.playing ? const Icon(Icons.pause): const Icon(Icons.play_arrow),
                      onPressed: () async {
                      ! _player.playing ?   _player.play() : _player.pause();
                      },
                    ),
                  if (processingState == ProcessingState.completed)
                    IconButton(
                      icon: const Icon(Icons.replay),
                      onPressed: () {
                        _player.seek(Duration.zero);
                        _player.play();
                      },
                    ),
                ],
              ),
              Slider(
                value: _player.position.inMilliseconds.toDouble(),
                min: 0,
                max: _player.duration == null ? 0.0 :  _player.duration!.inMilliseconds.toDouble(),
                onChanged: (value) {
                  _player.seek(Duration(milliseconds: value.toInt()));
                },
              ),
          ],
        );
      },
    );
  }
}
