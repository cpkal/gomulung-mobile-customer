part of 'map_bloc.dart';

sealed class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class MapPositionChanged extends MapEvent {
  final Position position;

  MapPositionChanged(this.position);

  @override
  List<Object> get props => [position];
}

class MapPositionPicked extends MapEvent {
  final Position position;

  MapPositionPicked(this.position);

  @override
  List<Object> get props => [position];
}
