import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:multi_languges/models/coupon.dart';

import 'package:multi_languges/widgets/dashboard/coupon_horisontal.dart';

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
      child: CarouselSlider(
        items: Coupon.coupons
            .map((e) => HorizontalCoupon(
                  coupon: e,
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
      ),
    );
  }
}
