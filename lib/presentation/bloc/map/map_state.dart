part of 'map_bloc.dart';

sealed class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => [];
}

final class MapInitial extends MapState {}

final class MapPositionUpdate extends MapState {
  final Position position;

  MapPositionUpdate(this.position);

  @override
  List<Object> get props => [position];
}
