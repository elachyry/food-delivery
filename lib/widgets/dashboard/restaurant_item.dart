import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_languges/models/restaurant.dart';
import 'package:multi_languges/screens/restaurant_details/restaurant_details_screen.dart';

class RestaurantItem extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantItem({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    var rating = 0.0;
    String delivery = restaurant.deliveryFee.toString();
    bool freedelivery = restaurant.deliveryFee == 0;
    for (var e in restaurant.ratings) {
      rating += e.rate;
    }
    rating = rating / restaurant.ratings.length;

    if (freedelivery) {
      delivery = 'Free Delivery';
    }
    return InkWell(
      onTap: () {
        Get.to(() => RestaurantDetailsScreen(restaurant: restaurant));
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
                    child: Image.network(
                      restaurant.imageUrl,
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
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
                        '${restaurant.distance}km',
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
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite_outline,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: restaurant.tags
                      .map(
                        (e) => restaurant.tags.indexOf(e) ==
                                restaurant.tags.length - 1
                            ? Text(
                                e,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: Colors.grey,
                                    ),
                                textAlign: TextAlign.center,
                              )
                            : Text(
                                '$e, ',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: Colors.grey,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                      )
                      .toList(),
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
                          '${rating.toStringAsFixed(1)} (${restaurant.ratings.length})',
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
