import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

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
        height: 55,
        width: 55,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).primaryColorLight.withAlpha(10)),
        child: Icon(
          leadingIcon,
          color: Theme.of(context).primaryColorDark,
          size: 30,
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
                  color: Theme.of(context).primaryColorLight.withAlpha(5)),
              child: Icon(
                Bootstrap.chevron_right,
                color: title == 'logout'.tr ? Colors.red : Colors.grey,
                size: 20,
              ),
            ),
    );
  }
}
