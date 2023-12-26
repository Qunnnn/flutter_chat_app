import 'package:flutter/material.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton(
      {super.key,
      this.text,
      this.fontWeight = FontWeight.bold,
      required this.onPressed});
  final String? text;
  final FontWeight? fontWeight;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        textStyle: TextStyle(
          fontSize: 20.0,
          fontWeight: fontWeight,
        ),
        padding: const EdgeInsets.symmetric(vertical: 10.0),
      ),
      child: Text(text ?? ''),
    );
  }
}
