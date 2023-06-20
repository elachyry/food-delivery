import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_delivery_express/utils/app_routes.dart';
import 'package:food_delivery_express/widgets/order/cancel_order_confirmation_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:easy_stepper/easy_stepper.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../controllers/order_controller.dart';
import '../../controllers/rating_controller.dart';
import '../../controllers/restaurant_controller.dart';
import '../../models/order.dart';
import '../../models/rating.dart';
import '../../models/restaurant.dart';
import 'feedback_item.dart';
import 'order_menu_item.dart';

class OrderItem extends StatefulWidget {
  const OrderItem({
    super.key,
    required this.restaurantController,
    required this.orders,
    required this.color,
    required this.status,
    required this.orderController,
    required this.index,
  });

  final RestaurantController restaurantController;
  final List<Order> orders;
  final Color color;
  final String status;
  final OrderController orderController;
  final int index;

  // final feedbackController = TextEditingController();

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool isExpanded = false;
  final ratingController = Get.put(RatingController());
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      color: Colors.grey.shade100,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      elevation: 3,
      child: InkWell(
        onTap: () {
          int activeStep = 0;
          if (widget.status == 'Accepted') {
            activeStep = 1;
          } else if (widget.status == 'Delivered') {
            activeStep = 2;
          } else if (widget.status == 'Cancelled') {
            activeStep = 1;
          }

          final Restaurant restaurant = widget.restaurantController.restaurants
              .firstWhere((element) =>
                  element.id == widget.orders[widget.index].restaurantId);

          orderShowBottomModelSheet(context, restaurant, activeStep);
        },
        child: Container(
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'order_Id'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 15, color: Colors.grey),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    widget.orders[widget.index].id,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 15, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              widget.restaurantController.restaurants
                                  .firstWhere((element) =>
                                      element.id ==
                                      widget.orders[widget.index].restaurantId)
                                  .logoUrl,
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      widget.restaurantController.restaurants
                          .firstWhere((element) =>
                              element.id ==
                              widget.orders[widget.index].restaurantId)
                          .name,
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 25),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        FittedBox(
                          child: Text(
                            DateFormat('dd MMM yyyy HH:mm').format(
                                DateTime.parse(
                                    widget.orders[widget.index].addedAt)),
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontSize: 13, color: Colors.grey),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).primaryColorDark),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                widget.orders[widget.index].total
                                    .toStringAsFixed(2),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                ' Dh',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    icon: Icon(
                      isExpanded ? Icons.expand_less : Icons.expand_more,
                      size: 35,
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                ],
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),

                // height: isExpanded ? widget.orders.length * 250 : 0,
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  child: !isExpanded
                      ? Container()
                      : Column(
                          children: [
                            // !isExpanded
                            //     ? Container()
                            //     :
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount: widget
                                  .orders[widget.index].menuItems.keys.length,
                              itemBuilder: (context, index2) {
                                return OrderMenuItem(
                                  menuItem: widget
                                      .orders[widget.index].menuItems.keys
                                      .elementAt(index2),
                                  quantity: widget
                                      .orders[widget.index].menuItems.values
                                      .elementAt(index2),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            AnimatedSize(
                              duration: const Duration(milliseconds: 300),
                              child: !isExpanded
                                  ? Container()
                                  : Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      margin: const EdgeInsets.only(bottom: 5),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'payment_method'.tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .copyWith(fontSize: 15),
                                              ),
                                              Text(
                                                widget.orders[widget.index]
                                                    .paymentMathode,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .copyWith(fontSize: 15),
                                              ),
                                            ],
                                          ),
                                          const Divider(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'address'.tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .copyWith(fontSize: 15),
                                              ),
                                              Text(
                                                widget.orders[widget.index]
                                                    .address,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .copyWith(fontSize: 15),
                                              ),
                                            ],
                                          ),
                                          const Divider(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'total'.tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .copyWith(fontSize: 15),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    widget.orders[widget.index]
                                                        .total
                                                        .toStringAsFixed(2),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium!
                                                        .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18,
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                        ),
                                                  ),
                                                  Text(
                                                    'Dh',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium!
                                                        .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 10,
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColorDark,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                          ],
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> orderShowBottomModelSheet(
    BuildContext context,
    Restaurant restaurant,
    int activeStep,
  ) {
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
    Rating? rate = ratingController.getRating(
        widget.orders[widget.index].consumerId,
        widget.orders[widget.index].restaurantId,
        '');
    double restaurnatRate = 0;
    if (rate != null) {
      restaurnatRate = rate.rate;
      ratingController.feedbackController.text = rate.comment;
    }

    rating = rating / ratings.length;
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      isScrollControlled: true,
      builder: (context) => Container(
        color: Colors.white,
        height: widget.status == 'Delivered'
            ? MediaQuery.of(context).size.height * 0.9
            : null,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(bottom: 15),
            child: Column(
              children: [
                Container(
                  height: 150,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(
                          MediaQuery.of(context).size.width, 40),
                    ),
                  ),
                  child: Obx(
                    () {
                      if (ratingController.ratings.isEmpty) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(
                                widget.restaurantController.restaurants
                                    .firstWhere((element) =>
                                        element.id ==
                                        widget
                                            .orders[widget.index].restaurantId)
                                    .logoUrl,
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.restaurantController.restaurants
                                    .firstWhere((element) =>
                                        element.id ==
                                        widget
                                            .orders[widget.index].restaurantId)
                                    .name,
                                overflow: TextOverflow.clip,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        fontSize: 25, color: Colors.white),
                              ),
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                          color: Colors.grey,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorDark,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: IconButton(
                              onPressed: () async {
                                String dialerUrl =
                                    'tel:${widget.restaurantController.restaurants.firstWhere((element) => element.id == widget.orders[widget.index].restaurantId).phone}';

                                if (await canLaunchUrl(Uri.parse(dialerUrl))) {
                                  await launchUrl(Uri.parse(dialerUrl));
                                } else {
                                  throw 'Could not launch phone dialer';
                                }
                              },
                              icon: const Icon(
                                Icons.phone,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                EasyStepper(
                  lineType: LineType.normal,
                  activeStep: activeStep + 1,
                  direction: Axis.horizontal,
                  unreachedStepIconColor: Colors.grey,
                  unreachedStepBorderColor: Colors.black54,
                  finishedStepBackgroundColor:
                      Theme.of(context).primaryColorDark,
                  unreachedStepBackgroundColor: Colors.white,
                  defaultStepBorderType: BorderType.dotted,
                  defaultLineColor: Colors.grey,
                  lineLength: MediaQuery.of(context).size.width / 4.5,
                  showTitle: true,
                  finishedStepTextColor: Colors.black,
                  onStepReached: (index) => setState(() => activeStep = index),
                  steps: widget.status == 'Cancelled'
                      ? [
                          EasyStep(
                            icon: const Icon(Bootstrap.hourglass_split),
                            title: 'pending'.tr,
                            activeIcon: const Icon(Bootstrap.hourglass_split),
                          ),
                          EasyStep(
                            icon: const Icon(Bootstrap.x),
                            activeIcon: const Icon(Bootstrap.x),
                            title: 'cancelled'.tr,
                          ),
                        ]
                      : [
                          EasyStep(
                            icon: const Icon(Bootstrap.hourglass_split),
                            title: 'pending'.tr,
                            activeIcon: const Icon(Bootstrap.hourglass_split),
                          ),
                          EasyStep(
                            icon: const Icon(Icons.check),
                            activeIcon: const Icon(Icons.check),
                            title: 'accepted'.tr,
                          ),
                          EasyStep(
                            icon: const Icon(Bootstrap.check_all),
                            activeIcon: const Icon(Bootstrap.check_all),
                            title: 'delivered'.tr,
                          ),
                        ],
                ),
                if (widget.status == 'Pending')
                  SizedBox(
                    child: Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () async {
                              bool shoudCancel =
                                  await CancelOrderConfirmationDialog.show(
                                      context) as bool;
                              if (shoudCancel) {
                                widget.orderController.cancelOrder(
                                    widget.orders[widget.index].id);
                                Navigator.of(context).popAndPushNamed(
                                    AppRoutes.ordersScreenRoute);
                              }
                            },
                            child: Text(
                              'cancel_this_order'.tr,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (widget.status == 'Delivered')
                  SizedBox(
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
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
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
                                  initialRating: rate == null ? 0.0 : rate.rate,
                                  direction: Axis.horizontal,
                                  itemSize: 40,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              height: 80,
                              child: TextField(
                                controller: ratingController.feedbackController,
                                focusNode: focusNode,
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    height: 50,
                                    child: Obx(() {
                                      if (ratingController.ratings.isEmpty) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }

                                      return ElevatedButton(
                                        onPressed: ratingController
                                                .isLoading.value
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
                                                        .feedbackController
                                                        .text ==
                                                    '') {
                                                  showSnackBar(
                                                      'error'.tr,
                                                      'please_enter_a_feedback',
                                                      Colors.red.shade400);
                                                  return;
                                                }
                                                if (rate == null) {
                                                  ratingController
                                                      .addRating(Rating(
                                                    custmerId: AuthController
                                                        .instance
                                                        .auth
                                                        .currentUser!
                                                        .uid,
                                                    restaurantId: widget
                                                        .orders[widget.index]
                                                        .restaurantId,
                                                    menuItemId: '',
                                                    rate: restaurnatRate,
                                                    comment: ratingController
                                                        .feedbackController
                                                        .text,
                                                    addedAt: DateTime.now()
                                                        .toIso8601String(),
                                                  ).toJson());

                                                  showSnackBar(
                                                      'success'.tr,
                                                      'you_have_been_added_the_feedback_successfully'
                                                          .tr,
                                                      Colors.green.shade400);
                                                  focusNode.unfocus();
                                                } else {
                                                  ratingController
                                                      .updateRating(rate.id, {
                                                    'stars': restaurnatRate,
                                                    'comment': ratingController
                                                        .feedbackController
                                                        .text,
                                                  });
                                                  showSnackBar(
                                                      'success'.tr,
                                                      'you_have_been_updated_the_feedback_successfully'
                                                          .tr,
                                                      Colors.green.shade400);
                                                  focusNode.unfocus();
                                                }
                                              },
                                        child: ratingController.isLoading.value
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              )
                                            : Text(
                                                rate == null
                                                    ? 'send_feedback'.tr
                                                    : 'update_your_feedback'.tr,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
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
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 220.0 *
                              widget.orders[widget.index].menuItems.length,
                          child: ListView.builder(
                              itemCount:
                                  widget.orders[widget.index].menuItems.length,
                              itemBuilder: (context, index) {
                                Rating? rate2 = ratingController.getRating(
                                    widget.orders[widget.index].consumerId,
                                    '',
                                    widget.orders[widget.index].menuItems.keys
                                        .elementAt(index)
                                        .id);

                                return FeedbackItem(
                                  widget2: widget,
                                  rating: rating,
                                  index: index,
                                  rate2: rate2,
                                );
                              }),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.restaurantController.restaurants
                            .firstWhere((element) =>
                                element.id ==
                                widget.orders[widget.index].restaurantId)
                            .name,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Text(
                            '${widget.orders[widget.index].total.toStringAsFixed(2)} Dh |',
                            style: TextStyle(
                                overflow: TextOverflow.clip,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade400),
                          ),
                          Text(
                            ' ${widget.orders[widget.index].menuItems.length} Menus |',
                            style: TextStyle(
                                overflow: TextOverflow.clip,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade400),
                          ),
                          Text(
                            ' ${widget.orders[widget.index].paymentMathode}',
                            style: TextStyle(
                                overflow: TextOverflow.clip,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade400),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        widget.restaurantController.restaurants
                            .firstWhere((element) =>
                                element.id ==
                                widget.orders[widget.index].restaurantId)
                            .location
                            .name,
                        style: TextStyle(
                            overflow: TextOverflow.clip,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade400),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        widget.restaurantController.restaurants
                            .firstWhere((element) =>
                                element.id ==
                                widget.orders[widget.index].restaurantId)
                            .phone,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade400),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                                setState(() {
                                  isExpanded = !isExpanded;
                                });
                              },
                              child: Text(
                                'see_details'.tr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context).primaryColorDark),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
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
