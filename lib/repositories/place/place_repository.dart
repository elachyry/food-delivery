import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:multi_languges/models/place.dart';

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
}
