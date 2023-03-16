import 'dart:async';

import 'package:flutter/material.dart';

import 'custom_notification_toast.dart';
import 'custom_toast.dart';

class CustomToastBuilder {
  OverlayEntry loadingCustomToast({required Widget? toast, String message = ""}) {
    return OverlayEntry(
      maintainState: false,
      builder: (context) {
        return toast!;
      },
    );
  }

  OverlayEntry customAnimatedToast(StreamController<double>? animationController,
      {required Widget? toast, ToastAnimation? toastAnimation, bool? hasBackGround}) {
    return OverlayEntry(
      maintainState: false,
      builder: (context) {
        var padding = MediaQuery.of(context).padding;
        Future.delayed(const Duration(milliseconds: 100), () {
          animationController!.sink.add(toastAnimation == ToastAnimation.bottomTop ? 0.87 : 5);
        });
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              color: hasBackGround! ? Color(0xff00000).withOpacity(0.55) : null,
            ),
            StreamBuilder<double>(
                initialData: toastAnimation == ToastAnimation.bottomTop ? 1 : -5,
                stream: animationController!.stream,
                builder: (context, snapshot) {
                  return AnimatedPositioned(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    top: toastAnimation == ToastAnimation.bottomTop
                        ? snapshot.data!
                        : snapshot.data! - (padding.top * padding.bottom) * snapshot.data!,
                    duration: const Duration(milliseconds: 200),
                    child: toast!,
                  );
                }),
          ],
        );
      },
    );
  }
}
