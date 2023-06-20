import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../blocs/cart/cart_bloc.dart';
import '../../blocs/coupon/coupon_bloc.dart';
import '../../models/coupon.dart';

class AddCouponBottomNavBar extends StatefulWidget {
  const AddCouponBottomNavBar({
    super.key,
  });

  @override
  State<AddCouponBottomNavBar> createState() => _AddCouponBottomNavBarState();
}

class _AddCouponBottomNavBarState extends State<AddCouponBottomNavBar> {
  final couponController = TextEditingController();

  void showSnackBar(String titleText, String messageText, Color color) {
    Get.snackbar(titleText, messageText,
        snackPosition: SnackPosition.TOP,
        backgroundColor: color,
        colorText: Colors.white,
        duration: const Duration(milliseconds: 1200));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            blurRadius: 5,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 25),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'coupon'.tr,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context)
                            .primaryColorLight
                            .withOpacity(0.1),
                        blurRadius: 20.0,
                        offset: const Offset(0, 10),
                      )
                    ],
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey.shade100),
                        ),
                        color: Colors.white),
                    child: TextField(
                      controller: couponController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "enter_your_coupon_here".tr,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    if (state is CartLoading) {
                      return const Scaffold(
                        body: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (state is CartLoaded) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 13, horizontal: 60),
                        ),
                        onPressed: () {
                          final couponCode = couponController.text;
                          if (couponCode.isEmpty) {
                            showSnackBar('error'.tr, 'please_enter_a_coupon'.tr,
                                Colors.red.shade500);
                            return;
                          }
                          try {
                            Coupon coupon = Coupon.coupons.firstWhere(
                                (element) =>
                                    element.code.toLowerCase() ==
                                    couponCode.toLowerCase().trim());

                            if (coupon.validation.isAfter(DateTime.now())) {
                              showSnackBar(
                                  'error'.tr,
                                  'This coupon is expired'.tr,
                                  Colors.red.shade500);
                              return;
                            }
                            if (coupon.conditionAmount >
                                state.cart.grandTotal(state.cart.menuItems)) {
                              showSnackBar(
                                  'error'.tr,
                                  'this_coupon_for_orders_over'.tr +
                                      '${coupon.conditionAmount.toStringAsFixed(0)}Dh' +
                                      'only.'.tr,
                                  Colors.red.shade500);

                              return;
                            }
                            context
                                .read<CouponBloc>()
                                .add(SelectCoupon(coupon: coupon));

                            showSnackBar(
                                'succes'.tr,
                                'the_coupon_added_successfully'.tr,
                                Colors.green.shade500);
                            Navigator.of(context).pop();
                          } catch (_) {
                            showSnackBar(
                                'error'.tr,
                                'this_coupon_is_not_valid_or_not_exist'.tr,
                                Colors.red.shade500);
                            return;
                          }
                        },
                        child: Text(
                          'apply'.tr,
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      );
                    } else {
                      return Center(
                        child:
                            Text('an_error_occurred_please_try_again_later'.tr),
                      );
                    }
                  },
                ),
              ]),
        ),
      ),
    );
  }
}
