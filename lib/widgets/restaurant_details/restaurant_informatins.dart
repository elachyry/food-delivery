import 'package:flutter/material.dart';
import 'package:multi_languges/models/restaurant.dart';
import 'package:multi_languges/widgets/restaurant_details/read_more_paragraph.dart';

class Restaurantinformations extends StatelessWidget {
  const Restaurantinformations({
    super.key,
    required this.restaurant,
  });

  final Restaurant? restaurant;

  @override
  Widget build(BuildContext context) {
    var rating = 0.0;
    String delivery = restaurant!.deliveryFee.toString();
    bool freedelivery = restaurant!.deliveryFee == 0;
    for (var e in restaurant!.ratings) {
      rating += e.rate;
    }
    if (freedelivery) {
      delivery = 'Free Delivery';
    }
    rating = rating / restaurant!.ratings.length;
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
        Row(
          children: restaurant!.tags
              .map(
                (e) => restaurant!.tags.indexOf(e) ==
                        restaurant!.tags.length - 1
                    ? Text(
                        e,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.grey,
                                ),
                        textAlign: TextAlign.center,
                      )
                    : Text(
                        '$e, ',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.grey,
                                ),
                        textAlign: TextAlign.center,
                      ),
              )
              .toList(),
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
                  '${rating.toStringAsFixed(1)} (${restaurant!.ratings.length})',
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
          text:
              '${restaurant!.name} is a cozy French bistro located in the heart of the city. The restaurant offers a warm and intimate atmosphere, with a rustic decor that transports you to the streets of Paris. The menu features classic French dishes, including escargots, bouillabaisse, and coq au vin, all made with the freshest ingredients. The wine list is extensive, featuring a variety of French and international wines to perfectly complement your meal. With its charming ambiance and delicious cuisine, "La Petite Maison" is the perfect spot for a romantic dinner or a night out with friends.',
        ),
      ],
    );
  }
}
