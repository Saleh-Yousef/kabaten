import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 70,
        width: 70,
        child: LoadingIndicator(
            indicatorType: Indicator.ballSpinFadeLoader,
            colors: [Colors.blueGrey],
            strokeWidth: 1,
            backgroundColor: Colors.transparent,
            pathBackgroundColor: Colors.transparent),
      ),
    );
  }
}
