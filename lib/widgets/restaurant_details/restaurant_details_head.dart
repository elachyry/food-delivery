import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_languges/models/restaurant.dart';
import 'package:multi_languges/utils/constants/image_constants.dart';

class RestaurantDetailsHead extends StatelessWidget {
  const RestaurantDetailsHead({
    super.key,
    required this.restaurant,
  });

  final Restaurant? restaurant;

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
              icon: const Icon(
                Icons.favorite_border_outlined,
                color: Colors.black,
                size: 25,
              ),
              onPressed: () {},
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
