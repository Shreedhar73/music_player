part of 'discover_bloc.dart';

@immutable 
abstract class DiscoverState extends Equatable{}

class DiscoverInitial extends DiscoverState{
  @override
  List<Object?> get props => [];

}

class DiscoverLoading extends DiscoverState {
  @override
  List<Object?> get props => [];

}

class AllSongsLoadedState extends DiscoverState{
  final List<SongModel?> songsList;
  AllSongsLoadedState({required this.songsList});

  @override
  List<Object?> get props => [songsList];
}

class DiscoverError extends DiscoverState {
  @override
  List<Object?> get props => [];
}