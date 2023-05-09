import 'package:multi_languges/models/place.dart';
import 'package:multi_languges/models/place_autocomplete.dart';

abstract class BasePlaceRepository {
  Future<List<PlaceAutoComplete>?> getAutocomplete(String input) async {}

  Future<Place?> getPlace(String id) async {}
}
