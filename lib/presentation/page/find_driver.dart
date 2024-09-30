import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:las_customer/core/route/route_paths.dart';
import 'package:las_customer/presentation/bloc/map/map_bloc.dart';
import 'package:las_customer/presentation/bloc/order/order_bloc.dart';
import 'package:las_customer/presentation/bloc/websocket/websocket_bloc.dart';
import 'package:latlong2/latlong.dart';

class FindDriverPage extends StatefulWidget {
  FindDriverPage({Key? key}) : super(key: key);

  @override
  _FindDriverPageState createState() => _FindDriverPageState();
}

class _FindDriverPageState extends State<FindDriverPage> {
  MapController mapController = MapController();

  bool isCrewFound = false;

  @override
  void initState() {
    //timeout 3 seconds until las crew found
    Future.delayed(Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          isCrewFound = true;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WebsocketBloc, WebsocketState>(
      builder: (context, state) {
        if (state is WebsocketConnected) {
          print('ai hiya');
        }

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
              backgroundColor:
                  Colors.transparent, // Make the AppBar transparent
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
              centerTitle: true,
              title: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(200),
                ),
                child: isCrewFound
                    ? Text('Kru LAS ditemukan')
                    : Text('Sedang mencari kru LAS'),
              ), //  Custom title
              titleTextStyle: Theme.of(context).textTheme.headlineSmall),
          //map
          body: BlocProvider(
            create: (context) => MapBloc(),
            child: BlocConsumer<MapBloc, MapState>(
              listener: (context, state) {
                if (state is MapPositionUpdate) {
                  mapController.move(
                      LatLng(state.position.latitude, state.position.longitude),
                      18);
                }
              },
              builder: (context, state) {
                return Stack(
                  children: [
                    FlutterMap(
                      mapController: mapController,
                      options: MapOptions(
                        onPositionChanged: (position, hasGesture) {
                          context.read<MapBloc>().add(MapPositionChanged(
                              Position(
                                  latitude: position.center.latitude,
                                  longitude: position.center.longitude,
                                  timestamp: DateTime.now(),
                                  accuracy: 0.0,
                                  altitude: 0.0,
                                  altitudeAccuracy: 0.0,
                                  heading: 0.0,
                                  headingAccuracy: 0.0,
                                  speed: 0.0,
                                  speedAccuracy: 0.0)));
                        },
                        initialZoom: 18,
                        initialCenter: state is MapPositionUpdate
                            ? LatLng(state.position.latitude,
                                state.position.longitude)
                            : LatLng(-6.1753924, 106.8271528),
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          subdomains: const ['a', 'b', 'c'],
                        ),
                      ],
                    ),
                    isCrewFound
                        ? _buildPanelOnOrderProcess()
                        : _buildPanelCancelOrder(),
                  ],
                );
              },
            ),
          ),
        );
      },
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
