import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

import '../controllers/category_controller.dart';
import './category.dart';

class CategoryFilter extends Equatable {
  final String id;
  final Category category;
  final bool value;

  final categoryContoller = Get.put(CategoryController());
  static List<CategoryFilter> filters = [];

  CategoryFilter({
    required this.id,
    required this.category,
    required this.value,
  }) {
    // filters = categoryContoller.categories
    //     .map(
    //       (e) => CategoryFilter(
    //         id: e.id,
    //         category: e,
    //         value: false,
    //       ),
    //     )
    //     .toList();
  }

  CategoryFilter copyWith({
    String? id,
    Category? category,
    bool? value,
  }) {
    return CategoryFilter(
        id: id ?? this.id,
        category: category ?? this.category,
        value: value ?? this.value);
  }

  @override
  List<Object?> get props => [
        id,
        category,
        value,
      ];
}
