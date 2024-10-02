import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapInitial()) {
    //ask permission
    _locationPermission();
    //if position already picked, use it else get current position

    // _getCurrentPosition().then((position) {
    //   print('Initial, ${position}');
    //   add(MapPositionChanged(position));
    // });

    on<GetCurrentPosition>((event, emit) async {
      print('xdd');
      emit(MapLoading());
      final position = await _getCurrentPosition();
      emit(CurrentPosition(LatLng(position.latitude, position.longitude)));
    });

    on<MapPositionChanged>((event, emit) {
      emit(MapPositionUpdate(event.position));
    });

    on<PickPosition>((event, emit) {
      print('Picked position: ${event.position}');
      emit(MapPositionPicked(event.position));
    });
  }

  Future _locationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }

  Future<Position> _getCurrentPosition() {
    return Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    )).then((value) {
      return value;
    });
  }
}
