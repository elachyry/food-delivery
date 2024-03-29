import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_delivery_express/controllers/dashboard_controller.dart';

class ReadMoreParagraph extends StatelessWidget {
  final String text;
  final controller = Get.put(DashboardController());

  ReadMoreParagraph({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            maxLines: controller.isExpanded.value ? null : 3,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Colors.black54,
                ),
            // overflow: TextOverflow.ellipsis,
          ),
          GestureDetector(
            onTap: () {
              controller.isExpanded.value = !controller.isExpanded.value;
            },
            child: Text(
              controller.isExpanded.value ? "read_less".tr : "read_more".tr,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).primaryColorDark,
                    decoration: TextDecoration.underline,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
