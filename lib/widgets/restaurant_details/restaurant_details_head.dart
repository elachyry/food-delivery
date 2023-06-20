import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:food_delivery_express/controllers/auth/user_controller.dart';
import 'package:food_delivery_express/controllers/restaurant_controller.dart';
import 'package:food_delivery_express/models/restaurant.dart';
import 'package:food_delivery_express/utils/constants/image_constants.dart';

import '../../blocs/favorites/favorites_bloc.dart';

class RestaurantDetailsHead extends StatelessWidget {
  RestaurantDetailsHead({
    super.key,
    required this.restaurant,
    required this.isFavorite,
  });
  final bool isFavorite;

  Restaurant? restaurant;

  final restaurantController = Get.put(RestaurantController());

  final userController = Get.put((UserController()));

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.elliptical(MediaQuery.of(context).size.width, 40),
            ),
            image: DecorationImage(
              image: NetworkImage(
                restaurant!.imageUrl,
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
                      .read<FavoritesBloc>()
                      .add(RemoveFavoriteEvent(restaurant!.id));
                } else {
                  context
                      .read<FavoritesBloc>()
                      .add(AddFavoriteEvent(restaurant!.id));
                }
              },
            ),
          ),
        ),
        Positioned(
          right: 12,
          top: MediaQuery.of(context).size.height * 0.2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: FadeInImage(
              imageErrorBuilder: (context, error, stackTrace) =>
                  Image.asset(ImageConstants.logoPlaceholder),
              placeholder: const AssetImage(ImageConstants.logoPlaceholder),
              image: NetworkImage(
                restaurant!.logoUrl,
              ),
              fit: BoxFit.cover,
              width: 80,
            ),
          ),
        )
      ],
    );
  }
}
