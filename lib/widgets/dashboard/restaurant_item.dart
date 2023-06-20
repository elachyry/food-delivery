import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:food_delivery_express/blocs/favorites/favorites_bloc.dart';
import 'package:food_delivery_express/controllers/auth/user_controller.dart';
import 'package:food_delivery_express/controllers/restaurant_controller.dart';
import 'package:food_delivery_express/models/restaurant.dart';
import 'package:food_delivery_express/screens/restaurant_details/restaurant_details_screen.dart';
import 'package:food_delivery_express/utils/constants/image_constants.dart';

import '../../controllers/menu_items_controller.dart';
import '../../controllers/rating_controller.dart';
import '../../models/rating.dart';

class RestaurantItem extends StatelessWidget {
  final Restaurant restaurant;
  final bool isFavorite;
  RestaurantItem({
    super.key,
    required this.restaurant,
    required this.isFavorite,
  });

  final ratingController = Get.put(RatingController());

  final menuItemsController = Get.put(MenuItemsController());

  final userController = Get.put((UserController()));

  final restaurantController = Get.put(RestaurantController());

  @override
  Widget build(BuildContext context) {
    String delivery = restaurant.deliveryFee.toString();
    bool freedelivery = restaurant.deliveryFee == 0;

    var rating = 0.0;
    ratingController.fetchRatings();
    List<Rating> ratings = [];
    ratingController.fetchRatings();
    if (ratingController.ratings.isNotEmpty) {
      for (var element in ratingController.ratings) {
        if (element.restaurantId == restaurant.id) {
          ratings.add(element);
          rating += element.rate;
        }
      }
    }

    rating = rating / ratings.length;

    if (freedelivery) {
      delivery = 'free_delivery'.tr;
    }
    return InkWell(
      onTap: () {
        menuItemsController.loadMenuItems();
        Get.to(() => RestaurantDetailsScreen(
              restaurant: restaurant,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 6,
          child: Column(
            children: <Widget>[
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    child: FadeInImage(
                        image: NetworkImage(
                          restaurant.imageUrl,
                        ),
                        imageErrorBuilder: (context, error, stackTrace) =>
                            Image.asset(ImageConstants.restaurnantPlaceholder),
                        placeholder: const AssetImage(
                            ImageConstants.restaurnantPlaceholder),
                        width: double.infinity,
                        height: 180,
                        fit: BoxFit.cover),
                  ),
                  Positioned(
                    right: 5,
                    top: 5,
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white70,
                      ),
                      child: Text(
                        '${restaurant.distance.toStringAsFixed(1)}km',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FittedBox(
                      child: Text(
                        restaurant.name,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (isFavorite) {
                          context
                              .read<FavoritesBloc>()
                              .add(RemoveFavoriteEvent(restaurant.id));
                        } else {
                          context
                              .read<FavoritesBloc>()
                              .add(AddFavoriteEvent(restaurant.id));
                        }
                      },
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_outline,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: SizedBox(
                  width: double.infinity,
                  height: 20,
                  child: ListView.builder(
                    itemCount: restaurant.tags.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        index == restaurant.tags.length - 1
                            ? Text(
                                restaurant.tags[index],
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: Colors.grey,
                                    ),
                                textAlign: TextAlign.center,
                              )
                            : Text(
                                '${restaurant.tags[index]}, ',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: Colors.grey,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          rating.isNaN || ratings.isEmpty
                              ? 'no_ratings'.tr
                              : '$rating (${ratings.length})',
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.delivery_dining_sharp,
                          color: freedelivery ? Colors.redAccent : Colors.grey,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          freedelivery ? delivery : '$delivery Dh',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  color: freedelivery
                                      ? Colors.redAccent
                                      : Colors.grey,
                                  fontWeight:
                                      freedelivery ? FontWeight.bold : null),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        const Icon(
                          Icons.schedule,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${restaurant.deliveryTime} min',
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
