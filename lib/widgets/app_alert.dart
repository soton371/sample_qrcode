import 'package:flutter/material.dart';
import 'package:sample_qrcode/config/colors.dart';

void appAlert(BuildContext context,
    {Widget? title, Widget? content, List<Widget>? actions, bool? barrier}) {
  showDialog(
      context: context,
      barrierDismissible: barrier ?? true,
      builder: (_) => AlertDialog(
            backgroundColor: AppColors.white,
            shape: const LinearBorder(),
            title: title,
            content: content,
            actions: actions,
          ));
}
