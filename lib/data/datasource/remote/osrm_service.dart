import 'dart:convert';

import 'package:http/http.dart' as http;

class OsrmService {
  //get polyline from origin to destination
  Future getPolyline(double originLat, double originLng, double destinationLat,
      double destinationLng) async {
    final response = await http.get(
        Uri.parse(
            'https://router.project-osrm.org/route/v1/driving/$originLng,$originLat;$destinationLng,$destinationLat?overview=full&geometries=geojson'),
        headers: {'User-Agent': 'MyApp/1.0 '});

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['routes'][0]['geometry']['coordinates'];
    } else {
      throw Exception('Failed to load polyline');
    }
  }
}
