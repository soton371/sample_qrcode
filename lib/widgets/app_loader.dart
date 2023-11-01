import 'package:flutter/material.dart';
import 'package:sample_qrcode/config/colors.dart';

void appLoader(BuildContext context, String msg) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
            backgroundColor: AppColors.white,
            shape: const LinearBorder(),
            title: Text(msg),
            content: const LinearProgressIndicator(),
          ));
}
