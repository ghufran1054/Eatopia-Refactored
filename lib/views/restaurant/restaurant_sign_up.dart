import 'package:eatopia_refactored/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import '../../widgets/custom_text_field.dart';

////IN FIRST PAGE WE WILL GET THE EMAIL AND PASSWORD AND VERIFY IF THE USER EXISTS OR NOT
class BusinessSignUpScreen extends StatefulWidget {
  const BusinessSignUpScreen({super.key});

  @override
  State<BusinessSignUpScreen> createState() => _BusinessSignUpScreenState();
}

class _BusinessSignUpScreenState extends State<BusinessSignUpScreen> {
  //This _formKey will help us validate the inputs (check whether the user has entered the correct input or not)
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final ownerController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final restaurantController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    ownerController.dispose();
    phoneController.dispose();
    addressController.dispose();
    confirmPasswordController.dispose();
    restaurantController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Stack(children: [
      Scaffold(
          appBar: AppBar(
              iconTheme: const IconThemeData(
                color: Colors.black,
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              toolbarHeight: 70,
              title: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                        image: AssetImage('assets/images/eatopia.png'),
                        height: 50),
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
                        'Setup Business Account',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              //Owner NAME TEXT FIELD
                              CustomTextField(
                                  icon: const Icon(
                                    Icons.person,
                                    color: Colors.black,
                                  ),
                                  labelText: 'Owner Name',
                                  hintText: 'Enter your name',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your name';
                                    }
                                    return null;
                                  },
                                  textController: ownerController,
                                  boxH: 100,
                                  primaryColor: primaryColor),
                              const SizedBox(height: 20),

                              //Restaurant NAME TEXT FIELD
                              CustomTextField(
                                  icon: const Icon(
                                    Icons.person,
                                    color: Colors.black,
                                  ),
                                  labelText: 'Restaurant Name',
                                  hintText: 'Enter your Restaurant name',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter Restaurant name';
                                    }
                                    return null;
                                  },
                                  textController: restaurantController,
                                  boxH: 100,
                                  primaryColor: primaryColor),
                              const SizedBox(height: 20),

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

                              //CONFIRM PASSWORD TEXT FIELD
                              PasswordTextField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    if (value.length < 6) {
                                      return 'Password must be at least 6 characters';
                                    }
                                    if (value != passwordController.text) {
                                      return 'Passwords do not match';
                                    }
                                    return null;
                                  },
                                  labelText: 'Confirm Password',
                                  hintText: 'Confirm your password',
                                  passwordController: confirmPasswordController,
                                  boxPassH: 100,
                                  primaryColor: primaryColor),
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
                                    }
                                    return null;
                                  },
                                  textController: phoneController,
                                  boxH: 100,
                                  primaryColor: primaryColor),
                              const SizedBox(height: 20),

                              //Address Text Field
                              CustomTextField(
                                  readOnly: true,
                                  inputType: TextInputType.streetAddress,
                                  icon: const Icon(
                                    Icons.location_on,
                                    color: Colors.black,
                                  ),
                                  labelText: 'Address',
                                  hintText: 'Select your address',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please Select your address';
                                    }
                                    return null;
                                  },
                                  textController: addressController,
                                  boxH: 100,
                                  primaryColor: primaryColor),
                              const SizedBox(height: 10),
                            ],
                          )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 3,
                              backgroundColor: Colors.white,
                              fixedSize: const Size(210, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          onPressed: () async {
                            Navigator.pushNamed(
                                context, RouteManager.mapScreen);
                          },
                          child: Text(
                            'Select Location from Maps',
                            style: TextStyle(
                                color: primaryColor, fontFamily: 'ubuntu-bold'),
                          )),
                      const SizedBox(height: 20),
                      ElevatedButton(
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
                        onPressed: () async {},
                        child: const Text('Register'),
                      ),
                    ],
                  ),
                ),
              ))),
      // Text('Already have an account?'),
    ]);
  }
}
