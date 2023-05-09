import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileListItem extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final VoidCallback onTap;
  const ProfileListItem({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.orange.shade50),
        child: Icon(
          leadingIcon,
          color: title == 'your_favorites'.tr ? Colors.red : Colors.orange,
          size: 35,
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.w600,
            color: title == 'logout'.tr ? Colors.red : null),
      ),
      trailing: title == 'logout'.tr
          ? null
          : Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.grey.shade100),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: title == 'logout'.tr ? Colors.red : Colors.grey,
                size: 20,
              ),
            ),
    );
  }
}
