import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:food_delivery_express/controllers/auth/auth_controller.dart';
import 'package:food_delivery_express/controllers/rating_controller.dart';
import 'package:food_delivery_express/models/rating.dart';

import 'order_item.dart';

class OrderGivingFeedback extends StatelessWidget {
  OrderGivingFeedback({
    super.key,
    required this.ratings,
    required this.widget,
  });

  final double ratings;
  final OrderItem widget;

  final ratingController = Get.put(RatingController());

  double restaurnatRate = 0;

  @override
  Widget build(BuildContext context) {
    Rating? rating = ratingController.getRating(
        widget.orders[widget.index].consumerId,
        widget.orders[widget.index].restaurantId,
        '');
    // if (rating != null) {
    //   ratingController.feedbackController.text = rating.comment;
    // }
    return SizedBox(
      child: Column(
        children: [
          const Divider(),
          Column(
            children: [
              Column(
                children: [
                  Text(
                    'rate_this_restaurant'.tr,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'tell_others_what_you_think'.tr,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Obx(() {
                if (ratingController.ratings.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Center(
                  child: RatingBar.builder(
                    initialRating: rating == null ? 0.0 : rating.rate,
                    direction: Axis.horizontal,
                    itemSize: 40,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      restaurnatRate = rating;
                    },
                  ),
                );
              }),
              const SizedBox(
                height: 8,
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 80,
                child: TextField(
                  controller: ratingController.feedbackController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    hintText: 'give_your_feedback'.tr,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      height: 50,
                      child: Obx(() {
                        if (ratingController.ratings.isEmpty) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return ElevatedButton(
                          onPressed: ratingController.isLoading.value
                              ? null
                              : () {
                                  if (restaurnatRate == 0) {
                                    showSnackBar(
                                        'error'.tr,
                                        'please_choose_a_rate'.tr,
                                        Colors.red.shade400);
                                    return;
                                  }
                                  if (ratingController
                                          .feedbackController.text ==
                                      '') {
                                    showSnackBar(
                                        'error'.tr,
                                        'please_enter_a_feedback'.tr,
                                        Colors.red.shade400);
                                    return;
                                  }
                                  if (rating == null) {
                                    ratingController.addRating(Rating(
                                      custmerId: AuthController
                                          .instance.auth.currentUser!.uid,
                                      restaurantId: widget
                                          .orders[widget.index].restaurantId,
                                      menuItemId: '',
                                      rate: restaurnatRate,
                                      comment: ratingController
                                          .feedbackController.text,
                                      addedAt: DateTime.now().toIso8601String(),
                                    ).toJson());
                                    ratingController.feedbackController.clear();
                                    showSnackBar(
                                        'success'.tr,
                                        'you_have_been_added_the_feedback_successfully'
                                            .tr,
                                        Colors.green.shade400);
                                  } else {
                                    ratingController.updateRating(rating.id, {
                                      'stars': restaurnatRate,
                                      'comment': ratingController
                                          .feedbackController.text,
                                    });
                                    showSnackBar(
                                        'success'.tr,
                                        'you_have_been_updated_the_feedback_successfully'
                                            .tr,
                                        Colors.green.shade400);
                                  }
                                },
                          child: ratingController.isLoading.value
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Text(
                                  rating == null
                                      ? 'send_feedback'.tr
                                      : 'update_your_feedback'.tr,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
          const Divider(),
          const SizedBox(
            height: 8,
          ),
          Column(
            children: [
              Text(
                'rate_restaurant_menus'.tr,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(
                'did_you_enjoy_it'.tr,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 10),
          //   height: 220.0 * widget.orders[widget.index].menuItems.length,
          //   child: ListView.builder(
          //     itemCount: widget.orders[widget.index].menuItems.length,
          //     itemBuilder: (context, index) => FeedbackItem(
          //       widget2: widget,
          //       rating: ratings,
          //       index: index,
          //     ),
          //   ),
          // ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }

  void showSnackBar(String title, String message, Color color) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: color,
      colorText: Colors.white,
      duration: const Duration(milliseconds: 1500),
    );
  }
}
