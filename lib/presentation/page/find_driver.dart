import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:las_customer/core/route/route_paths.dart';
import 'package:las_customer/data/model/order.dart';
import 'package:las_customer/presentation/bloc/crew/crew_bloc.dart';
import 'package:las_customer/presentation/bloc/map/map_bloc.dart';
import 'package:las_customer/presentation/bloc/websocket/websocket_bloc.dart';
import 'package:latlong2/latlong.dart';

class FindDriverPage extends StatefulWidget {
  Order order;
  FindDriverPage({Key? key, required this.order}) : super(key: key);

  @override
  _FindDriverPageState createState() => _FindDriverPageState();
}

class _FindDriverPageState extends State<FindDriverPage> {
  MapController mapController = MapController();

  bool isCrewFound = false;
  String message = '';
  LatLng? crewLocation;

  @override
  void initState() {
    //timeout 3 seconds until las crew found
    // context.read<WebsocketBloc>().add(WebsocketReceive('Listening to message'));

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WebsocketBloc, WebsocketState>(
      listener: (context, state) {
        if (state is WebsocketReceived) {
          setState(() {
            isCrewFound = true;
          });

          //decode message
          var data = jsonDecode(state.message);

          setState(() {
            crewLocation = LatLng(
              data['crew_location']['lat'],
              data['crew_location']['long'],
            );
          });

          context.read<CrewBloc>().add(GetCrewInfo(data['crew_id'].toString()));
          // context.read
          //get polyline from user location to crew location
          context.read<MapBloc>().add(GetPolyline(
              LatLng(widget.order.pickupLocation!.coordinates![1],
                  widget.order.pickupLocation!.coordinates![0]),
              crewLocation!));
        }
      },
      builder: (context, state) {
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
          body: Stack(
            children: [
              BlocBuilder<MapBloc, MapState>(
                builder: (context, state) {
                  return FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                      initialZoom: 18,
                      initialCenter: LatLng(
                          widget.order.pickupLocation!.coordinates![1],
                          widget.order.pickupLocation!.coordinates![0]),
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        subdomains: const ['a', 'b', 'c'],
                      ),
                      MarkerLayer(markers: [
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: LatLng(
                              widget.order.pickupLocation!.coordinates![1],
                              widget.order.pickupLocation!.coordinates![0]),
                          child: Container(
                            child: Icon(
                              Icons.person,
                              color: Colors.red,
                              size: 40,
                            ),
                          ),
                        ),

                        //if crew found
                        if (isCrewFound)
                          Marker(
                            width: 80.0,
                            height: 80.0,
                            point: crewLocation!,
                            child: Container(
                              child: Icon(
                                Icons.car_repair,
                                color: Colors.green,
                                size: 40,
                              ),
                            ),
                          ),
                      ]),
                      if (state is PolylineLoaded)
                        PolylineLayer(
                          polylines: [
                            if (state is PolylineLoaded)
                              Polyline(
                                points: state.polyline,
                                strokeWidth: 5.0,
                                color: Colors.blue,
                              ),
                          ],
                        )
                    ],
                  );
                },
              ),
              _buildPanelOnOrderProcess()
            ],
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
    return BlocBuilder<CrewBloc, CrewState>(
      builder: (context, state) {
        if (state is CrewLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is CrewLoaded) {
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
                              state.crew.name!,
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
                          widget.order.grandTotal.toString(),
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

        return Container();
      },
    );
  }
}
