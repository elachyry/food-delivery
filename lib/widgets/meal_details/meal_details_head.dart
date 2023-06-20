import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:food_delivery_express/blocs/favoriteMenuItems/favorite_menu_items_bloc.dart';

import '../../controllers/dashboard_controller.dart';
import '../../models/menu_item.dart';

class MealDetailsHead extends StatelessWidget {
  MealDetailsHead({
    super.key,
    required this.menuItem,
    required this.isFavorite,
  });

  final MenuItem? menuItem;
  final controller = Get.put(DashboardController());
  final bool isFavorite;

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
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_outline,
                color: Colors.red,
                size: 25,
              ),
              onPressed: () {
                if (isFavorite) {
                  context
                      .read<FavoriteMenuItemsBloc>()
                      .add(RemoveFavoriteMenuItemsEvent(menuItem!.id));
                } else {
                  context
                      .read<FavoriteMenuItemsBloc>()
                      .add(AddFavoriteMenuItemsEvent(menuItem!.id));
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
