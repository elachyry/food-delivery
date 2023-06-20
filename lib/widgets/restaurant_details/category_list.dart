import 'package:flutter/material.dart';
import 'package:food_delivery_express/models/restaurant.dart';

class CategoryList extends StatelessWidget {
  final int selectedIndex;
  final Function callBack;
  final Restaurant? restaurant;
  const CategoryList({
    super.key,
    required this.selectedIndex,
    required this.callBack,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    final categories = restaurant!.tags.toList();
    return SizedBox(
      height: 50,
      // padding: const EdgeInsets.all(5),
      child: ListView.separated(
        // padding: const EdgeInsets.all(15),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            callBack(index);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: selectedIndex == index ? Colors.white : null,
                border: Border.all(
                  width: 2,
                  color: selectedIndex == index
                      ? Theme.of(context).primaryColorLight
                      : Colors.transparent,
                )),
            child: Text(
              categories[index],
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: selectedIndex == index ? Colors.black : Colors.grey,
                    fontSize: selectedIndex == index ? 16 : 14.5,
                  ),
            ),
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(
          width: 20,
        ),
        itemCount: categories.length,
      ),
    );
  }
}
