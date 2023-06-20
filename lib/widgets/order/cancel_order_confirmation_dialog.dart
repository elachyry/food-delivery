import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CancelOrderConfirmationDialog {
  static Future<bool?> show(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'cancel_confirmation'.tr,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 15,
                ),
          ),
          content: Text(
            'do_you_want_to_cancel_this_order'.tr,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'no'.tr,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              onPressed: () {
                Navigator.of(context)
                    .pop(false); // Return false when cancel is pressed
              },
            ),
            ElevatedButton(
              child: Text(
                'yes'.tr,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              onPressed: () {
                Navigator.of(context)
                    .pop(true); // Return true when delete is pressed
              },
            ),
          ],
        );
      },
    );
  }
}
