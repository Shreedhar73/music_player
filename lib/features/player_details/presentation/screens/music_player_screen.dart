import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:google_fonts/google_fonts.dart';

@RoutePage()  
class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({super.key, this.song});
  final SongModel? song;

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A091E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A091E),
        foregroundColor: Colors.white,
        title: Text(widget.song!.title,style: const TextStyle(fontSize: 14),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.favorite))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
        child: Column(
          children: [
            QueryArtworkWidget(
              id: widget.song!.id, 
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
            ),
            const SizedBox(height: 5,),
            Text(
              widget.song!.title,
              style: GoogleFonts.mulish(
                color: Colors.white,
                fontSize: 18
              ),
            ),
            Text(
              widget.song!.artist!,
              style: GoogleFonts.mulish(
                color: const Color(0xFF8E8E8E),
                fontSize: 16
              ),
            ),
          ],
        ),
      ),
    );
  }
}