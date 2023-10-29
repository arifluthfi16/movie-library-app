import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Function()? onPressed;
  final bool isOutline;
  final bool isDisabled;
  final Icon? leftIcon;
  final bool isLoading;
  final double height;

  CustomButton({
    required this.text,
    this.backgroundColor = Colors.blue,
    this.onPressed,
    this.isOutline = false,
    this.isDisabled = false,
    this.leftIcon,
    this.isLoading = false,
    this.height = 18,
  });

  Widget _buildButtonContent() {
    if (isLoading) {
      return SizedBox(
        width: 24, // Adjust the width as needed
        height: 24, // Adjust the height as needed
        child: const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      final List<Widget> content = [];

      if (leftIcon != null) {
        content.add(leftIcon!);
        content.add(const SizedBox(width: 8.0));
      }

      if (!isLoading) {
        content.add(
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Inter',
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: content,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: isDisabled || isLoading ? null : onPressed,
        style: TextButton.styleFrom(
          primary: isOutline ? backgroundColor : Colors.white,
          backgroundColor: isOutline ? Colors.transparent : backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(48), // Adjust the border radius
            side: isOutline && !isDisabled
                ? BorderSide(color: backgroundColor, width: 2)
                : BorderSide.none,
          ),
          padding: EdgeInsets.symmetric(vertical: height), // Use customHeight here
          alignment: Alignment.center,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildButtonContent(),
          ],
        ),
      ),
    );
  }
}
