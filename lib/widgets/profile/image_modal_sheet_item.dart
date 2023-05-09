import 'package:flutter/material.dart';

class ImageModalSheetItem extends StatelessWidget {
  final String title;
  final IconData icon;
  const ImageModalSheetItem({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Colors.grey[200] as Color, blurRadius: 5, spreadRadius: 1),
        ],
      ),
      child: SizedBox(
        height: 100,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 5,
              ),
              Icon(
                icon,
                size: 50,
              ),
              Text(
                title,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
