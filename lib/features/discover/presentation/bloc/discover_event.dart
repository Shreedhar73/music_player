part of 'discover_bloc.dart';

@immutable
abstract class DiscoverEvent extends Equatable{}

class GetAllSongsEvent extends DiscoverEvent {
  GetAllSongsEvent();
  @override
  List<Object?> get props => [];

}