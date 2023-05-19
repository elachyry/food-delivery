import 'package:get/get.dart';

import '../models/ingredient.dart';
import '../repositories/repositories.dart';

class IngredientController extends GetxController {
  final IngredientRepository _ingrediantRepository =
      Get.put(IngredientRepository());

  RxList<Ingredient> ingrediants = RxList<Ingredient>();

  @override
  void onInit() {
    super.onInit();
    ingrediants.bindStream(_ingrediantRepository.getIngredientStream().map(
        (query) =>
            query.docs.map((doc) => Ingredient.fromFirestore(doc)).toList()));
  }
}
