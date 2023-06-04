
import 'package:equatable/equatable.dart';

class ProgressBarStateEntity extends Equatable{
  const ProgressBarStateEntity({
    required this.current,
    required this.buffered,
    required this.total,
  });
  final Duration current;
  final Duration buffered;
  final Duration total;
  @override
  List<Object?> get props => [];

}