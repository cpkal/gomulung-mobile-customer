import 'dart:convert';
import 'package:http/http.dart' as http;

class NominatimService {
  Future search(String query) async {
    final response = await http.get(
        Uri.parse(
            'https://nominatim.openstreetmap.org/reverse?$query&format=json'),

        //set user agent
        headers: {'User-Agent': 'MyApp/1.0 '});

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load places');
    }
  }
}
