import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:las_customer/core/route/route_paths.dart';
import 'package:las_customer/presentation/bloc/map/map_bloc.dart';
import 'package:las_customer/presentation/bloc/order/order_bloc.dart';
import 'package:las_customer/presentation/bloc/websocket/websocket_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';

class SellTrashPage extends StatefulWidget {
  // Constructor to accept the argument
  SellTrashPage({Key? key}) : super(key: key);

  @override
  _SellTrashPageState createState() => _SellTrashPageState();
}

class _SellTrashPageState extends State<SellTrashPage> {
  late MapController mapController;
  bool _isDragging = false;
  double? _prevLatitude;
  double? _prevLongitude;

  bool toggleMarker = false;

  // current selected marker location
  double? _selectedLatitude;
  double? _selectedLongitude;

  //list dropoff locations
  List<LatLng> dropOffLocations = [
    LatLng(-6.940363, 107.724643),
    LatLng(-6.939556, 107.726288),
    LatLng(-6.937650, 107.726336),
  ];

  List<String> dropOffLocationNames = [
    'Jl. Pendidikan',
    'Jl. Cibiru Indah III',
    'Jl. Permata 14',
  ];

  List<String> dropOffLocationDetail = [
    'Cibiru, Kec. Panyileukan, Kabupaten Bandung, Jawa Barat, Indonesia',
    'Cibiru, Kec. Panyileukan, Kabupaten Bandung, Jawa Barat, Indonesia',
    'Cibiru, Kec. Panyileukan, Kabupaten Bandung, Jawa Barat, Indonesia',
  ];

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

            return SlidingUpPanel(
              minHeight: 100,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              panel: Container(
                padding: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align content to the left
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Title Text
                      Text(
                        'Drop-off locations',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),

                      // List of nearby drop-off locations
                      ListView.builder(
                        itemCount: dropOffLocations.length,
                        shrinkWrap: true, // Prevent infinite height
                        physics:
                            NeverScrollableScrollPhysics(), // Disable ListView scrolling
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              // setState(() {
                              //   toggleMarker = !toggleMarker;
                              // });

                              setState(() {
                                // move camera
                                mapController.move(
                                    LatLng(dropOffLocations[index].latitude,
                                        dropOffLocations[index].longitude),
                                    mapController.camera.zoom);
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 6.0), // Add spacing between items
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.green,
                                    size: 30,
                                  ),
                                  SizedBox(
                                      width:
                                          8), // Spacing between icon and text
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              dropOffLocationNames[index],
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              '< 1 km',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height:
                                                2), // Reduce spacing between rows
                                        Text(
                                          dropOffLocationDetail[index],
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              body: Stack(
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
                        // context.read<MapBloc>().add(
                        //       MapPositionChanged(
                        //         LatLng(
                        //           position.center.latitude,
                        //           position.center.longitude,
                        //         ),
                        //       ),
                        //     );
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
                      MarkerLayer(
                        markers: dropOffLocations.map((e) {
                          return Marker(
                            width: 80.0,
                            height: 80.0,
                            point: e,
                            child: GestureDetector(
                              onTap: () {
                                //modal dialog
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title:
                                          Text('Navigasi ke titik drop-off?'),
                                      content: Text(dropOffLocationDetail[
                                          dropOffLocations.indexOf(e)]),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Tidak'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            // open google map
                                            openGoogleMap(
                                                e.latitude, e.longitude);
                                          },
                                          child: Text('Navigasi'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Icon(
                                Icons.location_on,
                                color: Colors.green,
                                size: 30,
                              ),
                            ),
                          );
                        }).toList(), // Important: Add `.toList()` at the end of `.map()`
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
                ],
              ),
            );
          }

          return Container();
        },
      ),
    );
  }

  Future<void> openGoogleMap(double lat, double long) async {
    final googleMapsUrl =
        "https://www.google.com/maps/dir/?api=1&destination=$lat,$long&travelmode=driving&dir_action=navigate";

    print(googleMapsUrl);

    if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
      await launchUrl(Uri.parse(googleMapsUrl));
    } else {
      throw 'Could not open Google Maps.';
    }
  }
}
