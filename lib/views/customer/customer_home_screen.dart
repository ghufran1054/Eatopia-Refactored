import 'package:flutter/material.dart';

class CustomerHomeScreen extends StatelessWidget {
  const CustomerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Eatopia"),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome to Eatopia!",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              "This is the customer home page.",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
