import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  VoidCallback? onPressed;
  final String buttonText;
  IconData? icon;
  CustomElevatedButton(
      {super.key, this.icon, this.onPressed, required this.buttonText});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          side: const BorderSide(
            color: Colors.white,
            width: 2,
            style: BorderStyle.solid,
          ),
          backgroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon == null
                ? const SizedBox()
                : Icon(
                    icon,
                    size: 30,
                    color: Colors.white,
                  ),
            Text(
              buttonText,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
          ],
        ));
  }
}
