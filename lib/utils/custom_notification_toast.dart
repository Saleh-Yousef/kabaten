import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../../main.dart';
import '../../locator.dart';
import 'custom_toast_builder.dart';

enum ToastType { loading, animatedToast }

enum ToastAnimation { bottomTop, topBottom }

class CustomNotificationToast extends RouteObserver {
  OverlayEntry? _overlayEntry;
  ToastType? _toastType;
  Route? toastRoute;
  final CustomToastBuilder _toastBuilder = CustomToastBuilder();
  _RemoveOverlayEntryHandler? _removeOverlayEntry;
  StreamController<double>? _controller;

  void showLoading({Duration? duration, Widget? toast, Function? onDismissAction}) {
    _buildingToast(toastType: ToastType.loading, overlayEntry: _toastBuilder.loadingCustomToast(toast: toast), onDismissFunction: onDismissAction);
    _removeOverlayEntry!.dismissToastAfterDuration(duration);
  }

  void _buildingToast({OverlayEntry? overlayEntry, ToastType? toastType, ToastAnimation? toastAnimation, Function? onDismissFunction}) {
    _removeOverlayEntry?.removeOverlay();
    _toastType = toastType;
    _overlayEntry = overlayEntry;
    _removeOverlayEntry = _RemoveOverlayEntryHandler(onDismissFunction,
        overlayEntry: _overlayEntry, toastType: _toastType, controller: _controller, toastAnimation: toastAnimation);
    navigatorKey.currentState?.overlay?.insert(overlayEntry!);
  }

  void finish({Function? onDismissAction}) {
    _removeOverlayEntry?.removeOverlay();
  }
}

class _RemoveOverlayEntryHandler {
  OverlayEntry? overlayEntry;
  final ToastAnimation? toastAnimation;
  final ToastType? toastType;
  final Function? onDismissAction;
  final StreamController<double>? controller;
  _RemoveOverlayEntryHandler(this.onDismissAction, {this.overlayEntry, this.toastType, this.controller, this.toastAnimation});

  void dismissToastAfterDuration(Duration? duration) {
    duration = duration ?? const Duration(seconds: 5);
    Future.delayed(duration, () {
      finish();
    });
  }

  void finish() {
    if (toastType == ToastType.animatedToast) {
      finishAnimated();
    }
    removeOverlay();
    if (locator<CustomNotificationToast>().toastRoute != null) {
      if (onDismissAction != null && locator<CustomNotificationToast>().toastRoute!.isActive) {
        onDismissAction!();
      }
    }
  }

  void finishAnimated() async {
    controller!.sink.add(toastAnimation == ToastAnimation.bottomTop ? 1 : -5);
    await Future.delayed(const Duration(milliseconds: 200));
  }

  void removeOverlay() {
    if (overlayEntry != null) {
      overlayEntry!.remove();
      overlayEntry = null;
    }
  }
}
