import 'package:food_delivery_express/models/place.dart';
import 'package:food_delivery_express/models/place_autocomplete.dart';

abstract class BasePlaceRepository {
  Future<List<PlaceAutoComplete>?> getAutocomplete(String input) async {}

  Future<Place?> getPlace(String id) async {}
}
