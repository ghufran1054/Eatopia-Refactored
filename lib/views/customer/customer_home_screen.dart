// ignore_for_file: use_build_context_synchronously

import 'package:eatopia_refactored/firebase/authentication/auth_services.dart';
import 'package:eatopia_refactored/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerHomeScreen extends StatelessWidget {
  const CustomerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Eatopia"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome to Eatopia!",
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            const Text(
              "This is the customer home page.",
              style: TextStyle(fontSize: 18),
            ),
            TextButton(
                onPressed: () async {
                  await context.read<AuthServices>().signOut();
                  Navigator.pushReplacementNamed(
                      context, RouteManager.welcomeScreen);
                },
                child: const Text("Logout")),
            const SizedBox(height: 20),
            TextButton(onPressed: () {}, child: const Text("Business Sign Up")),
          ],
        ),
      ),
    );
  }
}
