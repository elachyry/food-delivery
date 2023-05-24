import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../controllers/rating_controller.dart';
import '../../models/rating.dart';
import '../../utils/constants/image_constants.dart';
import 'order_item.dart';

class FeedbackItem extends StatefulWidget {
  FeedbackItem(
      {super.key,
      required this.widget2,
      required this.rating,
      required this.index,
      required this.rate2});

  final OrderItem widget2;
  final double rating;
  final int index;
  final Rating? rate2;
  double menuItemRate = 0;

  @override
  State<FeedbackItem> createState() => _FeedbackItemState();
}

class _FeedbackItemState extends State<FeedbackItem> {
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (widget.rate2 != null) {
      widget.menuItemRate = widget.rate2!.rate;
      feedbackController2.text = widget.rate2!.comment;
    }
    super.didChangeDependencies();
  }

  TextEditingController feedbackController2 = TextEditingController();

  final ratingController = Get.put(RatingController());

  @override
  Widget build(BuildContext context) {
    // Rating? rate2 = ratingController.getRating(
    //     widget.widget2.orders[widget.widget2.index].consumerId,
    //     '',
    //     widget.widget2.orders[widget.widget2.index].menuItems.keys
    //         .elementAt(widget.index)
    //         .id);
    if (widget.rate2 != null) {
      setState(() {
        widget.menuItemRate = widget.rate2!.rate;
      });
    }
    final FocusNode focusNode = FocusNode();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: FadeInImage(
                      placeholder:
                          const AssetImage(ImageConstants.menuItemPlaceholder),
                      imageErrorBuilder: (context, error, stackTrace) =>
                          Image.asset(ImageConstants.menuItemPlaceholder),
                      image: NetworkImage(
                        widget
                            .widget2.orders[widget.widget2.index].menuItems.keys
                            .elementAt(widget.index)
                            .imageUrl,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 5,
                child: Text(
                  widget.widget2.orders[widget.widget2.index].menuItems.keys
                      .elementAt(widget.index)
                      .name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Center(
                  child: RatingBar.builder(
                    initialRating:
                        widget.rate2 == null ? 0.0 : widget.rate2!.rate,
                    direction: Axis.horizontal,
                    itemSize: 25,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        widget.menuItemRate = rating;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 80,
            child: TextField(
              controller: feedbackController2,
              focusNode: focusNode,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade100,
                hintText: 'Give your feedback...',
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
                      onPressed: ratingController.isLoading2.value
                          ? null
                          : () {
                              if (widget.menuItemRate == 0) {
                                showSnackBar('Error', 'Please choose a rate',
                                    Colors.red.shade400);
                                return;
                              }
                              if (ratingController.feedbackController.text ==
                                  '') {
                                showSnackBar('Error', 'Please enter a feedback',
                                    Colors.red.shade400);
                                return;
                              }
                              if (widget.rate2 == null) {
                                ratingController.addRating(Rating(
                                  custmerId: AuthController
                                      .instance.auth.currentUser!.uid,
                                  restaurantId: '',
                                  menuItemId: widget
                                      .widget2
                                      .orders[widget.widget2.index]
                                      .menuItems
                                      .keys
                                      .elementAt(widget.index)
                                      .id,
                                  rate: widget.menuItemRate,
                                  comment: feedbackController2.text,
                                  addedAt: DateTime.now().toIso8601String(),
                                ).toJson());
                                showSnackBar(
                                    'success',
                                    'You have been added the feedback successfully.',
                                    Colors.green.shade400);
                                focusNode.unfocus();
                              } else {
                                ratingController
                                    .updateRating(widget.rate2!.id, {
                                  'stars': widget.menuItemRate,
                                  'comment': feedbackController2.text,
                                });
                                focusNode.unfocus();

                                showSnackBar(
                                    'success',
                                    'You have been updated the feedback successfully.',
                                    Colors.green.shade400);
                              }
                            },
                      child: Text(
                        widget.rate2 != null
                            ? 'Update your Feedback'
                            : 'Send Feedback',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    );
                  }),
                ),
              ),
            ],
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
