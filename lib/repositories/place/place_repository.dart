import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:food_delivery_express/models/place.dart';

import '../../models/place_autocomplete.dart';
import '/repositories/place/base_place_repository.dart';

class PlaceRepository extends BasePlaceRepository {
  final String key = 'AIzaSyA52adhAtOF_JtvChF7AXSaHwLqNRd5ozE';
  final String types = 'geocode';
  @override
  Future<List<PlaceAutoComplete>> getAutocomplete(String input) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=$types&key=$key';

    var response = await http.get(Uri.parse(url));
    var json = jsonDecode(response.body);
    var results = json['predictions'] as List;
    return results.map((e) => PlaceAutoComplete.fromJson(e)).toList();
  }

  @override
  Future<Place> getPlace(String id) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$id&key=$key';

    var response = await http.get(Uri.parse(url));
    var json = jsonDecode(response.body);
    var results = json['result'] as Map<String, dynamic>;

    return Place.fromJson(results);
  }

  // Future<bool> checkLocationRange(double userLat, double userLng) async {
  //   const String city = 'Dakhla'; // Replace with the desired city name

  //   final geocodingUrl = Uri.parse(
  //       'https://maps.googleapis.com/maps/api/geocode/json?address=$city&key=$key');

  //   final geocodingResponse = await http.get(geocodingUrl);
  //   final geocodingData = json.decode(geocodingResponse.body);

  //   print('geocodingData $geocodingData');
  //   final double latitude =
  //       geocodingData['results'][0]['geometry']['location']['lat'];
  //   final double longitude =
  //       geocodingData['results'][0]['geometry']['location']['lng'];

  //   final String placeId = geocodingData['results'][0]['place_id'];

  //   final placesUrl = Uri.parse(
  //       'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key');

  //   final placesResponse = await http.get(placesUrl);
  //   final placesData = json.decode(placesResponse.body);

  //   final Map<String, dynamic> boundaries =
  //       placesData['result']['geometry']['viewport']['northeast'];

  //   final double boundaryLatitude = boundaries['lat'];
  //   final double boundaryLongitude = boundaries['lng'];

  //   print('boundaryLatitude $boundaryLatitude');
  //   print('boundaryLongitude $boundaryLongitude');

  //   const double radius = 6371; // Earth's radius in kilometers

  //   final double centerDistance = calculateDistance(
  //       latitude, longitude, boundaryLatitude, boundaryLongitude, radius);
  //   final double locationDistance =
  //       calculateDistance(latitude, longitude, userLat, userLng, radius);
  //   print(
  //       'locationDistance <= centerDistance ${locationDistance <= centerDistance}');

  //   return locationDistance <= centerDistance;
  // }

  // double calculateDistance(
  //     double lat1, double lon1, double lat2, double lon2, double radius) {
  //   final double dLat = radians(lat2 - lat1);
  //   final double dLon = radians(lon2 - lon1);

  //   final double a = pow(sin(dLat / 2), 2) +
  //       cos(radians(lat1)) * cos(radians(lat2)) * pow(sin(dLon / 2), 2);

  //   final double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  //   return radius * c;
  // }

  // double radians(double degrees) {
  //   return degrees * (pi / 180);
  // }
}
