// ignore_for_file: use_build_context_synchronously

import 'package:eatopia_refactored/firebase/authentication/auth_services.dart';
import 'package:eatopia_refactored/routes/routes.dart';
import 'package:eatopia_refactored/widgets/custom_text_field.dart';
import 'package:eatopia_refactored/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //This _formKey will help us validate the inputs (check whether the user has entered the correct input or not)
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          toolbarHeight: 70,
          title:
              const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image(image: AssetImage('assets/images/eatopia.png'), height: 50),
            SizedBox(width: 10),
            Text('EATOPIA',
                style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 2,
                    fontSize: 30,
                    fontWeight: FontWeight.bold))
          ])),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Login',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 40),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    //EMAIL TEXT FIELD
                    CustomTextField(
                        icon: const Icon(
                          Icons.email,
                          color: Colors.black,
                          size: 20,
                        ),
                        labelText: 'Email',
                        hintText: 'Enter your email',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!EmailValidator.validate(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        textController: emailController,
                        boxH: 100,
                        primaryColor: primaryColor),
                    const SizedBox(height: 20),

                    PasswordTextField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        passwordController: passwordController,
                        boxPassH: 100,
                        primaryColor: primaryColor),
                    const SizedBox(height: 20),
                  ],
                )),
            Consumer<AuthServices>(
              builder: (context, value, child) {
                return ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(primaryColor),
                        fixedSize: MaterialStateProperty.all<Size>(Size(
                            MediaQuery.of(context).size.width / 3,
                            MediaQuery.of(context).size.height / 18)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        )),
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      String result = await value.signInWithEmail(
                          emailController.text, passwordController.text);
                      if (result != 'SUCCESS') {
                        showSnackBar(context, result);
                      } else {
                        context.read<AuthServices>().redirectToScreen(context);
                      }
                    },
                    child: value.processing
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 1,
                          )
                        : const Text(
                            'Login',
                          ));
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account?'),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(primaryColor),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, RouteManager.userSignUpScreenOne);
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
