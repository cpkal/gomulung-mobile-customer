import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:las_customer/core/route/route_paths.dart';
import 'package:las_customer/presentation/bloc/map/map_bloc.dart';
import 'package:las_customer/presentation/bloc/order/order_bloc.dart';
import 'package:las_customer/presentation/bloc/websocket/websocket_bloc.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  // Constructor to accept the argument
  MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late MapController mapController;
  bool _isDragging = false;
  double? _prevLatitude;
  double? _prevLongitude;

  @override
  void initState() {
    mapController = MapController();
    context.read<MapBloc>().add(GetCurrentPosition());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make the AppBar transparent
        elevation: 0, // Remove shadow
        leading: Container(
          //circle white container
          margin: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_back,
                color: Colors.black), // Custom back button icon
            onPressed: () {
              Navigator.of(context).pop(); // Navigate back
            },
          ),
        ),
      ),
      //map
      body: BlocConsumer<MapBloc, MapState>(
        listener: (context, state) {
          if (state is MapPositionUpdate) {
            mapController.move(
                LatLng(state.position.latitude, state.position.longitude), 18);
          }
        },
        builder: (context, state) {
          if (state is MapLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is CurrentPosition) {
            //save current psotion to variabel
            _prevLatitude = state.position.latitude;
            _prevLongitude = state.position.longitude;

            return Stack(
              children: [
                FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    interactionOptions: InteractionOptions(
                      flags: InteractiveFlag.drag |
                          InteractiveFlag.rotate |
                          InteractiveFlag.doubleTapZoom,
                    ),
                    onPositionChanged: (position, hasGesture) {
                      context.read<MapBloc>().add(
                            MapPositionChanged(
                              LatLng(
                                position.center.latitude,
                                position.center.longitude,
                              ),
                            ),
                          );
                    },
                    initialZoom: 18,
                    initialCenter: LatLng(
                      state.position.latitude,
                      state.position.longitude,
                    ),
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: const ['a', 'b', 'c'],
                    ),
                  ],
                ),

                //positioned buttons for zoom in, zoom out, and my location
                Positioned(
                  //middle right
                  right: 10,
                  top: MediaQuery.of(context).size.height * 0.3,
                  child: Column(
                    children: [
                      Container(
                        //border grey
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Container(
                          //white background
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: IconButton(
                            onPressed: () {
                              mapController.move(
                                  LatLng(_prevLatitude!, _prevLongitude!),
                                  mapController.camera.zoom);
                            },
                            icon: Icon(Icons.my_location),
                            padding: EdgeInsets.all(20),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        //border grey
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: IconButton(
                          onPressed: () {
                            mapController.move(
                                LatLng(state.position.latitude,
                                    state.position.longitude),
                                mapController.camera.zoom + 1);
                          },
                          icon: Icon(Icons.add),
                          padding: EdgeInsets.all(20),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        //border grey
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: IconButton(
                          onPressed: () {
                            mapController.move(
                                LatLng(state.position.latitude,
                                    state.position.longitude),
                                mapController.camera.zoom - 1);
                          },
                          icon: Icon(Icons.remove),
                          padding: EdgeInsets.all(20),
                        ),
                      ),
                    ],
                  ),
                ),

                Center(
                  child: Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 50,
                  ),
                ),
                _buildPanelPickMapLocation(state)
              ],
            );
          }

          if (state is MapPositionUpdate) {
            return Stack(
              children: [
                FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    interactionOptions: InteractionOptions(
                      flags: InteractiveFlag.drag |
                          InteractiveFlag.rotate |
                          InteractiveFlag.doubleTapZoom,
                    ),
                    onPositionChanged: (position, hasGesture) {
                      if (hasGesture) {
                        context.read<MapBloc>().add(
                              MapPositionChanged(
                                LatLng(
                                  position.center.latitude,
                                  position.center.longitude,
                                ),
                              ),
                            );

                        // setState(() {
                        //   _isDragging = true;
                        // });
                      } else {
                        //call api to get address
                        // setState(() {
                        //   _isDragging = false;
                        // });
                      }
                    },
                    initialZoom: 18,
                    initialCenter: LatLng(
                        state.position.latitude, state.position.longitude),
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: const ['a', 'b', 'c'],
                    ),
                  ],
                ),

                //positioned buttons for zoom in, zoom out, and my location
                Positioned(
                  //middle right
                  right: 10,
                  top: MediaQuery.of(context).size.height * 0.3,
                  child: Column(
                    children: [
                      Container(
                        //border grey
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: IconButton(
                          onPressed: () {
                            mapController.move(
                                LatLng(_prevLatitude!, _prevLongitude!),
                                mapController.camera.zoom);
                          },
                          icon: Icon(Icons.my_location),
                          padding: EdgeInsets.all(20),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        //border grey
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: IconButton(
                          onPressed: () {
                            mapController.move(
                                LatLng(state.position.latitude,
                                    state.position.longitude),
                                mapController.camera.zoom + 1);
                          },
                          icon: Icon(Icons.add),
                          padding: EdgeInsets.all(20),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        //border grey
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: IconButton(
                          onPressed: () {
                            mapController.move(
                                LatLng(state.position.latitude,
                                    state.position.longitude),
                                mapController.camera.zoom - 1);
                          },
                          icon: Icon(Icons.remove),
                          padding: EdgeInsets.all(20),
                        ),
                      ),
                    ],
                  ),
                ),

                //center marker
                Center(
                  child: Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 50,
                  ),
                ),

                _buildPanelPickMapLocation(state)
              ],
            );
          }

          return Container();
        },
      ),
    );
  }

  Widget _buildPanelPickMapLocation(state) {
    return Positioned(
      bottom: 0,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(),
            onPressed: () {
              context.read<MapBloc>().add(PickPosition(LatLng(
                  mapController.camera.center.latitude,
                  mapController.camera.center.longitude)));

              context.read<OrderBloc>().add(PickOrderLocation(
                  position: LatLng(mapController.camera.center.latitude,
                      mapController.camera.center.longitude)));

              Navigator.of(context).pop();
            },
            child: Text('Pilih Lokasi'),
          ),
        ),
      ),
    );
  }

  Widget _buildPanelCancelOrder() {
    return Positioned(
      bottom: 0,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              side: BorderSide(
                color: Theme.of(context).colorScheme.error,
                width: 1,
              ),
              backgroundColor: Theme.of(context).colorScheme.surface,
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Batalkan pesanan'),
          ),
        ),
      ),
    );
  }

  Widget _buildPanelOnOrderProcess() {
    return Positioned(
      bottom: 0,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'John Doe',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text('B 1234 ABC',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Text(
                    'Rp. 10.000',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text('Estimasi waktu sampai 10 menit',
                  style: Theme.of(context).textTheme.bodyLarge),
              SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    //border grey
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.phone),
                      padding: EdgeInsets.all(20),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    //border grey
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RoutePaths.chat);
                      },
                      icon: Icon(Icons.chat),
                      padding: EdgeInsets.all(20),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    //border grey
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.edit),
                      padding: EdgeInsets.all(20),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
