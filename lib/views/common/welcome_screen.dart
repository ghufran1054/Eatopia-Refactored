// ignore_for_file: use_build_context_synchronously

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatopia_refactored/firebase/authentication/auth_services.dart';
import 'package:eatopia_refactored/routes/routes.dart';
import 'package:eatopia_refactored/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/eatopia.png',
              width: MediaQuery.of(context).size.width * 0.35,
              height: MediaQuery.of(context).size.height * 0.25,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteManager.loginScreen);
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(255, 45),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                  // change background color of button
                  backgroundColor: Theme.of(context)
                      .primaryColor, // change text color of button
                ),
                child: const Text(
                  "Login with Email",
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context, RouteManager.userSignUpScreenOne);
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(255, 45),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  foregroundColor: Colors.white,
                  // change background color of button
                  backgroundColor: Theme.of(context)
                      .primaryColor, // change text color of button
                ),
                child: const Text(
                  "Sign up with Email",
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ),
            Container(
              width: 250,
              height: 3,
              decoration: BoxDecoration(
                color: Colors.grey[350],
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(255, 45),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                foregroundColor: Colors.white,
                // change background color of button
                backgroundColor: Colors.white, // change text color of button
              ),
              onPressed: () async {
                String result =
                    await context.read<AuthServices>().signInWithGoogle();
                if (result != "SUCCESS") {
                  showSnackBar(context, result);
                  return;
                }
                Navigator.pushReplacementNamed(
                    context, RouteManager.customerHomeScreen);
              },
              label: const Text(
                "Continue with Google",
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
              icon: Image.asset(
                'assets/images/google.png',
                height: 30,
              ),
            )
          ],
        ),
      ),
    ));
  }
}
