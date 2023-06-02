import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/core/router/app_router.dart';
import 'package:music_player/features/discover/presentation/bloc/discover_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
@RoutePage()  
class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Music List', style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold),),
          SizedBox(
            height: MediaQuery.of(context).size.height-kBottomNavigationBarHeight - 50,
            child: BlocBuilder<DiscoverBloc,DiscoverState>(
              bloc: context.read<DiscoverBloc>()..add(GetAllSongsEvent()),
              builder: (context, state) {
                if(state is AllSongsLoadedState){
                  return CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context ,index){
                            SongModel? song = state.songsList[index];
                            return songTile(song!);
                          },
                          childCount: state.songsList.length
                        ),
                      ),
                    ],
                  );
                }else {
                  return const SizedBox();
                }
              },
            ),
          ),
          
        ],
      ),
    );
  }

  songTile(SongModel song){
    return ListTile(
      minVerticalPadding: 0,
      contentPadding: EdgeInsets.zero,
      title: Text(song.displayName,style: const TextStyle(color: Colors.white),),
      onTap: () {
        context.router.push(
          MusicPlayerRoute(
            song: song
          ),
        );
      },
      leading: QueryArtworkWidget(
        id: song.id,
        type: ArtworkType.AUDIO,
      )
    );
  }
}