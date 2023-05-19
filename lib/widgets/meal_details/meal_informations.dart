import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:multi_languges/controllers/dashboard_controller.dart';

import '../../models/menu_item.dart';

class Mealinformations extends StatelessWidget {
  Mealinformations({
    super.key,
    required this.menuItem,
  });

  final MenuItem? menuItem;
  final controller = Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    var rating = 0.0;

    for (var e in menuItem!.ratings) {
      rating += e.rate;
    }

    rating = rating / menuItem!.ratings.length;

    String elements = '';

    int size = menuItem!.elements.length;

    int i = 0;
    for (var e in menuItem!.elements) {
      if (i == size - 1) {
        elements += '${e['quantity']}x${e['name']}';
      } else {
        elements += '${e['quantity']}x${e['name']}, ';
      }
      i++;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                child: Text(
                  menuItem!.name,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FittedBox(
                child: Text(
                  elements,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 15, color: Colors.grey),
                  softWrap: true,
                  overflow: TextOverflow.fade,
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
                        '${rating.toStringAsFixed(1)} (${menuItem!.ratings.length} Reviews)',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10)),
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            if (controller.mealQty.value == 1) {
                              return;
                            }
                            controller.mealQty.value -= 1;
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Container(
                              color: Colors.grey.shade300,
                              child: const Icon(
                                Bootstrap.dash,
                                size: 28,
                              ),
                            ),
                          ),
                        ),
                        Obx(
                          () => Container(
                            // height: 25,
                            // width: 20,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.05)),
                            child: Text(
                              controller.mealQty.value.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.mealQty.value += 1;
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Container(
                              color: Theme.of(context).primaryColorDark,
                              child: const Icon(
                                Bootstrap.plus,
                                size: 28,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 18,
        ),
        Text(
          '${menuItem!.description} ',
          overflow: TextOverflow.clip,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.black54,
              ),
        ),
        const SizedBox(
          height: 50,
        ),
        FittedBox(
          child: Text(
            'Ingredients',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
            softWrap: true,
            overflow: TextOverflow.fade,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: double.infinity,
          height: 100,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  width: 80,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.network(
                        menuItem!.ingredients[index].imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        menuItem!.ingredients[index].name,
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                    width: 10,
                  ),
              itemCount: menuItem!.ingredients.length),
        )
      ],
    );
  }
}
