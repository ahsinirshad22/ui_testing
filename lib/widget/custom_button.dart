import 'package:flutter/material.dart';
import 'package:studio_93_test/utils/app_color.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final VoidCallback? onTap;

  const CustomButton(
      {super.key,
      required this.title,
      this.backgroundColor,
      this.borderColor,
      this.textColor,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        decoration: BoxDecoration(
            color: backgroundColor ?? Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: borderColor ?? AppColor.secondaryColor)),
        child: Text(
          title,
          style: TextStyle(fontSize: 10, color: textColor),
        ),
      ),
    );
  }
}
