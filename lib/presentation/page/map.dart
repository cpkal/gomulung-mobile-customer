import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:las_customer/core/route/route_paths.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
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
          centerTitle: true,
          title: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(200),
            ),
            child: Text('Sedang mencari kru LAS'),
          ), // Custom title
          titleTextStyle: Theme.of(context).textTheme.headlineSmall),
      //map
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialZoom: 18,
              initialCenter: LatLng(-6.1753924, 106.8271528),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
              ),
            ],
          ),
          // _buildPanelCancelOrder(),
          _buildPanelOnOrderProcess()
        ],
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
