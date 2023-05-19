import 'package:get/get.dart';

import '../models/category.dart';
import '../repositories/repositories.dart';

class CategoryController extends GetxController {
  final CategoryRepository _categoryRepository = Get.put(CategoryRepository());

  RxList<Category> categories = RxList<Category>();

  @override
  void onInit() {
    super.onInit();
    categories.bindStream(_categoryRepository.getCategoryStream().map((query) =>
        query.docs.map((doc) => Category.fromFirestore(doc)).toList()));
  }
}
