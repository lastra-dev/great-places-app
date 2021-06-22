import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class LocationHelper {
  static String generateLocationPreviewImage({
    required double latitude,
    required double longitude,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=${dotenv.env['GOOGLE_API_KEY']}';
  }

  static Future<String> getAdress({
    required double latitude,
    required double longitude,
  }) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=${dotenv.env['GOOGLE_API_KEY']}',
    );
    final response = await http.get(url);
    final responseBody = json.decode(response.body);
    return responseBody['results'][0]['formatted_address'].toString();
  }
}
