import 'package:flutter/material.dart';

class InfoBanner {
  static bool isShowing = false;

  static void showBanner(
    BuildContext context,
    Color backgroundColor,
    String text,
  ) {
    if (isShowing) hideBanner(context);
    isShowing = true;
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        leading: const Icon(Icons.info),
        backgroundColor: backgroundColor,
        content: Text(text),
        actions: [
          IconButton(
            onPressed: () => hideBanner(context),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
    Future.delayed(const Duration(seconds: 3), () => hideBanner(context));
  }

  static void hideBanner(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    isShowing = false;
  }
}
