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
                            return songTile(state.songsList,index);
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

  songTile(List<SongModel?> songList,int index){
    return ListTile(
      minVerticalPadding: 0,
      contentPadding: EdgeInsets.zero,
      title: Text(songList[index]!.displayName,style: const TextStyle(color: Colors.white),),
      onTap: () {
        context.router.push(
           MusicPlayerRoute(
            songList : songList,
            index: index
          ),
        );
      },
      leading: QueryArtworkWidget(
        id: songList[index]!.id,
        type: ArtworkType.AUDIO,
      )
    );
  }
}