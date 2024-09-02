import 'package:flutter/material.dart';

class DefaultIconBack extends StatelessWidget {
  double left;
  double top;

  DefaultIconBack({
    super.key,
    required this.left,
    required this.top,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(
        Icons.arrow_back_ios,
        size: 35,
        color: Colors.white,
      ),
    );
  }
}
