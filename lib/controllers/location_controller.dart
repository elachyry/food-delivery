import 'package:get/get.dart';

import '../models/place_autocomplete.dart';
import '../repositories/place/place_repository.dart';

class LocationController extends GetxController {
  var isClear = true.obs;
  var isWithinRange = true.obs;
  var isLoading = false.obs;

  RxList<PlaceAutoComplete> autoComplete = RxList<PlaceAutoComplete>();

  getAutoCompleteList(String input) async {
    // autoComplete.value = [];
    PlaceRepository placeRepository = PlaceRepository();
    autoComplete.value = await placeRepository.getAutocomplete(input);
    // print('auto complete $autoComplete');
  }
}
