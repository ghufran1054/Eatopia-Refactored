// ignore_for_file: use_build_context_synchronously

import 'package:eatopia_refactored/firebase/authentication/auth_services.dart';
import 'package:eatopia_refactored/models/customer.dart';
import 'package:eatopia_refactored/routes/routes.dart';
import 'package:eatopia_refactored/widgets/custom_text_field.dart';
import 'package:eatopia_refactored/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';

String email = '';

////IN FIRST PAGE WE WILL GET THE EMAIL AND PASSWORD AND VERIFY IF THE USER EXISTS OR NOT
class UserSignUpScreenOne extends StatefulWidget {
  const UserSignUpScreenOne({super.key});

  @override
  State<UserSignUpScreenOne> createState() => _UserSignUpScreenOneState();
}

class _UserSignUpScreenOneState extends State<UserSignUpScreenOne> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
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
              'Sign Up',
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
                  ],
                )),
            //NEXT SCREEN BUTTON
            Consumer<AuthServices>(
              builder: (context, value, child) {
                return ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(primaryColor),
                      fixedSize: MaterialStateProperty.all<Size>(Size(
                          MediaQuery.of(context).size.width / 3,
                          MediaQuery.of(context).size.height / 18)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      )),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      email = emailController.text;
                      bool exists =
                          await value.emailExists(emailController.text);
                      if (exists) {
                        showSnackBar(context, 'User already exists');
                      } else {
                        Navigator.pushNamed(
                          context,
                          RouteManager.userSignUpScreenTwo,
                        );
                      }
                    }
                  },
                  child: value.processing
                      ? const CircularProgressIndicator(
                          strokeWidth: 1.2,
                          color: Colors.white,
                        )
                      : const Text('Continue'),
                );
              },
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account?'),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(primaryColor),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, RouteManager.loginScreen);
                  },
                  child: const Text(
                    'Log In',
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

//USER SIGN - UP PAGE TWO TAKE INPUT FOR USERNAME, PHONE NUMBER AND ADDRESS AND THEN THE SIGN UP IS COMPLETE

class UserSignUpScreenTwo extends StatefulWidget {
  const UserSignUpScreenTwo({super.key});

  @override
  State<UserSignUpScreenTwo> createState() => _UserSignUpScreenTwoState();
}

class _UserSignUpScreenTwoState extends State<UserSignUpScreenTwo> {
  final _formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    userNameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.black,
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
                        //USER NAME TEXT FIELD
                        CustomTextField(
                            icon: const Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                            labelText: 'User Name',
                            hintText: 'Enter your user name',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your user name';
                              }
                              return null;
                            },
                            textController: userNameController,
                            boxH: 100,
                            primaryColor: primaryColor),
                        const SizedBox(height: 20),
                        //PASSWORD TEXT FIELD
                        PasswordTextField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            passwordController: passwordController,
                            boxPassH: 100,
                            primaryColor: primaryColor),
                        const SizedBox(height: 20),
                        //Confirm PASSWORD TEXT FIELD
                        PasswordTextField(
                          labelText: 'Confirm',
                          hintText: 'Enter your password again',
                          passwordController: confirmPasswordController,
                          boxPassH: 100,
                          primaryColor: primaryColor,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password again';
                            }
                            if (value != passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        //Phone Number Text Field
                        CustomTextField(
                            inputType: TextInputType.phone,
                            icon: const Icon(
                              Icons.phone,
                              color: Colors.black,
                            ),
                            labelText: 'Phone Number',
                            hintText: 'Enter your phone number',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your phone number';
                              } else if (int.tryParse(value) == null ||
                                  value.length < 10) {
                                return 'Please enter a valid phone number';
                              }
                              return null;
                            },
                            textController: phoneController,
                            boxH: 100,
                            primaryColor: primaryColor),
                        const SizedBox(height: 20),

                        //Address Text Field
                        CustomTextField(
                            inputType: TextInputType.streetAddress,
                            icon: const Icon(
                              Icons.location_on,
                              color: Colors.black,
                            ),
                            labelText: 'Address',
                            hintText: 'Enter your address',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your address';
                              }
                              return null;
                            },
                            textController: addressController,
                            boxH: 100,
                            primaryColor: primaryColor),
                        const SizedBox(height: 10),
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
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            )),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            Customer customer = Customer(
                              name: userNameController.text,
                              email: email,
                              phone: phoneController.text,
                              address: addressController.text,
                            );
                            String result = await value.signUpCustomerwithEmail(
                                customer, passwordController.text);
                            if (result == 'SUCCESS') {
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  RouteManager.customerHomeScreen,
                                  (route) => false);
                            } else {
                              showSnackBar(context, result);
                            }
                          }
                        },
                        child: value.processing
                            ? const CircularProgressIndicator(
                                strokeWidth: 1,
                                color: Colors.white,
                              )
                            : const Text('Sign Up'));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
