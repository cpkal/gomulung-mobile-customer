part of 'map_bloc.dart';

sealed class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class MapPositionChanged extends MapEvent {
  final LatLng position;

  MapPositionChanged(this.position);

  @override
  List<Object> get props => [position];
}

class PickPosition extends MapEvent {
  final LatLng position;

  PickPosition(this.position);

  @override
  List<Object> get props => [position];
}

class GetCurrentPosition extends MapEvent {}

class GetAddressFromPosition extends MapEvent {
  final LatLng position;

  GetAddressFromPosition(this.position);

  @override
  List<Object> get props => [position];
}

class GetPolyline extends MapEvent {
  final LatLng origin;
  final LatLng destination;

  GetPolyline(this.origin, this.destination);

  @override
  List<Object> get props => [origin, destination];
}
