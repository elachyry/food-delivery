import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:clipboard/clipboard.dart';

import 'package:food_delivery_express/widgets/dashboard/coupon_horisontal.dart';

import '../../blocs/coupon/coupon_bloc.dart';

class CouponSlide extends StatelessWidget {
  const CouponSlide({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 5,
        bottom: 5,
      ),
      color: Colors.grey.shade200,
      alignment: Alignment.topCenter,
      child: BlocBuilder<CouponBloc, CouponState>(
        builder: (context, state) {
          if (state is CouponLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CouponLoaded) {
            return CarouselSlider(
              items: state.coupons
                  .map((e) => GestureDetector(
                        onTap: () {
                          FlutterClipboard.copy(e.code)
                              .then((value) => Get.snackbar(
                                    'succes'.tr,
                                    'The Coupon code copied to clipboard.',
                                    snackPosition: SnackPosition.TOP,
                                    backgroundColor: Colors.green.shade500,
                                    colorText: Colors.white,
                                    duration:
                                        const Duration(milliseconds: 1500),
                                  ));
                        },
                        child: HorizontalCoupon(
                          coupon: e,
                        ),
                      ))
                  .toList(),
              options: CarouselOptions(
                aspectRatio: 24 / 8,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 4),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                onPageChanged: (index, reason) {},
                scrollDirection: Axis.horizontal,
              ),
            );
          } else {
            return Center(
              child: Text('an_error_occurred_please_try_again_later'.tr),
            );
          }
        },
      ),
    );
  }
}
