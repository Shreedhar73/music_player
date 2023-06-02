import 'package:on_audio_query/on_audio_query.dart';

abstract class DiscoverMusicDataSource{
  Future<List<SongModel?>> getAllSongs();
}

class DiscoverMusicDataSourceImpl implements DiscoverMusicDataSource{
  DiscoverMusicDataSourceImpl();
  final OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  Future<List<SongModel?>> getAllSongs() async{
    try{
      var songLists = await _audioQuery.querySongs();
      return songLists;
    }catch(e){
      throw Exception('Failed to Fetch article');
    }
  }

}