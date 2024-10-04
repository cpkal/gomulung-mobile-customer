part of 'map_bloc.dart';

sealed class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => [];
}

final class MapInitial extends MapState {}

final class MapLoading extends MapState {}

final class MapPositionUpdate extends MapState {
  final LatLng position;

  MapPositionUpdate(this.position);

  @override
  List<Object> get props => [position];
}

final class CurrentPosition extends MapState {
  final LatLng position;

  CurrentPosition(this.position);

  @override
  List<Object> get props => [position];
}

final class MapPositionPicked extends MapState {
  final LatLng position;

  MapPositionPicked(this.position);

  @override
  List<Object> get props => [position];
}

final class AddressFromPosition extends MapState {
  final String address;

  AddressFromPosition(this.address);

  @override
  List<Object> get props => [address];
}

final class PolylineLoaded extends MapState {
  final List<LatLng> polyline;

  PolylineLoaded(this.polyline);

  @override
  List<Object> get props => [polyline];
}
