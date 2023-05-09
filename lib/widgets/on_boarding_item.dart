import 'package:flutter/material.dart';

import '../models/on_boarding.dart';

class OnBoardingItem extends StatelessWidget {
  const OnBoardingItem({
    super.key,
    required this.onBoarding,
  });

  final OnBoarding onBoarding;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(30),
      color: onBoarding.bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Image.asset(
            onBoarding.image,
            height: size.height * 0.4,
          ),
          Column(
            children: [
              Text(
                onBoarding.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                onBoarding.subTitle,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
              ),
            ],
          ),
          // Text(
          //   onBoarding.countText,
          //   style: Theme.of(context).textTheme.headline6,
          // ),
          const SizedBox(
            height: 90,
          )
        ],
      ),
    );
  }
}
