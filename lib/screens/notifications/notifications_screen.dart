import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool newItems = false;
  bool notifications = true;
  bool newRestaurant = false;
  bool orderUpdates = false;
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
      ),
      centerTitle: true,
      title: Text(
        'notifications'.tr,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
      ),
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          height:
              MediaQuery.of(context).size.height - appBar.preferredSize.height,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(vertical: 5),
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: SwitchListTile(
                  value: notifications,
                  onChanged: (value) {
                    setState(() {
                      notifications = value;
                    });
                  },
                  title: Text(
                    'notifications'.tr,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(vertical: 10),
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: SwitchListTile(
                  value: notifications ? orderUpdates : false,
                  onChanged: (value) {
                    setState(() {
                      if (notifications) {
                        orderUpdates = value;
                      }
                    });
                  },
                  title: Text(
                    'order_updates'.tr,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'notification_when_your_order_status_changes'.tr,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(vertical: 10),
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: SwitchListTile(
                  value: notifications ? newRestaurant : false,
                  onChanged: (value) {
                    setState(() {
                      if (notifications) {
                        newRestaurant = value;
                      }
                    });
                  },
                  title: Text(
                    'new_restaurants'.tr,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'notification_when_a_new_restaurant_joins_us'.tr,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SwitchListTile(
                  value: notifications ? newItems : false,
                  onChanged: (value) {
                    setState(() {
                      if (notifications) {
                        newItems = value;
                      }
                    });
                  },
                  title: Text(
                    'new_items'.tr,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'notification_when_your_favorites_restaurants_add_new_menus'
                        .tr,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
