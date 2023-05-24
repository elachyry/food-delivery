import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_languges/models/restaurant.dart';
import 'package:multi_languges/widgets/restaurant_details/read_more_paragraph.dart';

import '../../controllers/rating_controller.dart';
import '../../models/rating.dart';

class Restaurantinformations extends StatelessWidget {
  Restaurantinformations({
    super.key,
    required this.restaurant,
  });
  final ratingController = Get.put(RatingController());

  final Restaurant? restaurant;

  @override
  Widget build(BuildContext context) {
    // var rating = 0.0;

    // for (var e in restaurant!.ratings) {
    //   rating += e.rate;
    // }

    // rating = rating / restaurant!.ratings.length;

    var rating = 0.0;
    ratingController.fetchRatings();
    List<Rating> ratings = [];
    if (ratingController.ratings.isNotEmpty) {
      for (var element in ratingController.ratings) {
        if (element.restaurantId == restaurant!.id) {
          ratings.add(element);
          rating += element.rate;
        }
      }
    }

    rating = rating / ratings.length;
    // for (var e in restaurant!.ratingsId) {
    //   Rating rat =
    //       ratingController.ratings.firstWhere((element) => element.id == e);
    //   rating += rat.rate;
    // }

    String delivery = restaurant!.deliveryFee.toString();
    bool freedelivery = restaurant!.deliveryFee == 0;

    if (freedelivery) {
      delivery = 'Free Delivery';
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          child: Text(
            restaurant!.name,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
            softWrap: true,
            overflow: TextOverflow.fade,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          width: double.infinity,
          height: 20,
          child: ListView.builder(
            itemCount: restaurant!.tags.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => index ==
                    restaurant!.tags.length - 1
                ? Text(
                    restaurant!.tags[index],
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.grey,
                        ),
                    textAlign: TextAlign.center,
                  )
                : Text(
                    '${restaurant!.tags[index]}, ',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.grey,
                        ),
                    textAlign: TextAlign.center,
                  ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      ? 'No ratings'
                      : '$rating (${ratings.length})',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
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
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: freedelivery ? Colors.redAccent : Colors.grey,
                      fontWeight: freedelivery ? FontWeight.bold : null),
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
                  '${restaurant!.deliveryTime} min',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.grey,
                      ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 18,
        ),
        ReadMoreParagraph(
          text: '${restaurant!.name} ${restaurant!.description}',
        ),
      ],
    );
  }
}
