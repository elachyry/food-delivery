import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/dashboard_controller.dart';
import '../../models/menu_item.dart';

class MealDetailsHead extends StatelessWidget {
  MealDetailsHead({
    super.key,
    required this.menuItem,
  });

  final MenuItem? menuItem;
  final controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.elliptical(MediaQuery.of(context).size.width, 40),
            ),
            image: DecorationImage(
              image: NetworkImage(
                menuItem!.imageUrl,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 50,
          left: 20,
          child: CircleAvatar(
            radius: 22,
            backgroundColor: Colors.white54,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.black,
                size: 25,
              ),
              onPressed: () {
                controller.mealQty.value = 1;
                Get.back();
              },
            ),
          ),
        ),
        Positioned(
          top: 50,
          right: 20,
          child: CircleAvatar(
            radius: 22,
            backgroundColor: Colors.white54,
            child: IconButton(
              icon: const Icon(
                Icons.favorite_border_outlined,
                color: Colors.black,
                size: 25,
              ),
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }
}
