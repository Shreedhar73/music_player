import 'package:music_player/features/player_details/domain/entities/progressbarstate_entity.dart';

class ProgressBarState extends ProgressBarStateEntity {
  const ProgressBarState({
    required current,
    required buffered,
    required total,
  }) : super(
    current: current,
    buffered: buffered,
    total: total
  );
}