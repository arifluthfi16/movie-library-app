import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Function()? onPressed;
  final bool isOutline;
  final bool isDisabled;

  CustomButton({
    required this.text,
    this.backgroundColor = Colors.blue,
    this.onPressed,
    this.isOutline = false,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Ensure the parent widget is set to full width
      child: TextButton(
        onPressed: isDisabled ? null : onPressed,
        style: TextButton.styleFrom(
          primary: isOutline ? backgroundColor : Colors.white,
          backgroundColor: isOutline ? Colors.transparent : backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(48),
            side: isOutline && !isDisabled
                ? BorderSide(color: backgroundColor, width: 2)
                : BorderSide.none,
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.center,
        ),
        child: Text(text, style: const TextStyle(
          fontSize: 16,
          fontFamily: 'Inter',
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),),
      ),
    );
  }
}
