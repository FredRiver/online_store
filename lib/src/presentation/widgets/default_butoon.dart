import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  String text;
  Function() onPressed;
  Color color;

  DefaultButton(
      {required this.text, required this.onPressed, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed;
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
      ),
      child: Text(text),
    );
  }
}
