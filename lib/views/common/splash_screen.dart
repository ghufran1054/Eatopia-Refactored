import 'package:eatopia_refactored/firebase/authentication/auth_services.dart';
import 'package:eatopia_refactored/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ThemeManager>().loadTheme();
    Future.delayed(const Duration(seconds: 3), () {
      context.read<AuthServices>().redirectToScreen(context);
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
              image: const AssetImage("assets/images/eatopia.png"),
              width: MediaQuery.sizeOf(context).width / 2,
              height: MediaQuery.sizeOf(context).height / 2),
          const SizedBox(height: 20),
          SpinKitThreeBounce(
            color: Theme.of(context).colorScheme.primary,
            size: MediaQuery.sizeOf(context).width / 50 +
                MediaQuery.sizeOf(context).height / 40,
          ),
        ],
      ),
    );
  }
}
