import 'package:flutter/material.dart';
import 'package:sample_qrcode/config/colors.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key, required this.name, this.bgColor = AppColors.seed, this.textColor = AppColors.white, required this.onPressed});
  final Color? bgColor, textColor;
  final String name;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: bgColor,
                        shape: const LinearBorder()),
                    onPressed: onPressed,
                    child: Text(
                      name,
                      style: TextStyle(color: textColor),
                    ));
  }
}