import 'package:flutter/material.dart';

import '../../../locator.dart';
import '../shared_widgets/loadingView.dart';
import 'custom_notification_toast.dart';

enum ToastEnum { successful, failed, pending }

class NotificationsUtility {
  void loading({Duration duration = const Duration(minutes: 4), required VoidCallback dismissAction, bool isFullScreen = false}) {
    locator<CustomNotificationToast>().showLoading(
      toast: const LoadingView(),
      duration: duration,
      onDismissAction: () {
        Future.delayed(const Duration(milliseconds: 10), () {
          dismissAction();
        });
      },
    );
  }

  void dismissToast() {
    locator<CustomNotificationToast>().finish();
  }
}
