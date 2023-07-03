import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class OverlayLoader extends StatelessWidget {
  const OverlayLoader({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300]!.withOpacity(0.55),
      ),
      child: Center(
        child: SpinKitThreeBounce(
          color: Theme.of(context).colorScheme.primary,
          size: height * 0.05 > 50 ? 50 : height * 0.05,
        ),
      ),
    );
  }
}
