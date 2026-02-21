import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

void showTopErrorSnackBar(BuildContext context, {required String text}) {
  // Remove any existing snack bar
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  // Show the custom top error snack bar
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.red100,
      margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
      content: InkWell(
        onTap: () {
          try {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
          } catch (_) {}
        },
        child: Row(
          children: [
            const Icon(Icons.error_outline, color: AppColors.appBackground),
            const SizedBox(width: 8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Text(
                  text,
                  //style:
                  //    textTheme.medium.copyWith(color: AppColors.appBackground),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void showNetWorkErrorSnackBar(BuildContext context) {
  showTopErrorSnackBar(context, text: "通信エラーが発生しました。ネットワーク環境をご確認の上、再度お試しください。");
}
