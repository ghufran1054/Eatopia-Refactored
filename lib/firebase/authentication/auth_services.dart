// ignore_for_file: use_build_context_synchronously

import 'package:eatopia_refactored/firebase/database/database_service.dart';
import 'package:eatopia_refactored/models/customer.dart';
import 'package:eatopia_refactored/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Customer? _customer;
  bool processing = false;

  Customer? get customer => _customer;
  User? get user => _auth.currentUser;

  Future<String> signInWithEmail(String email, String password) async {
    processing = true;
    notifyListeners();
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .timeout(const Duration(seconds: 10),
              onTimeout: () => throw FirebaseAuthException(
                  message:
                      "The connection has timed out, please try again later.",
                  code: "timeout"));
    } on FirebaseAuthException catch (e) {
      processing = false;
      notifyListeners();
      return e.message!;
    }
    processing = false;
    notifyListeners();
    return "SUCCESS";
  }

  Future<String> _signUpWithEmail(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      return e.message!;
    }
    return "SUCCESS";
  }

  Future<String> signUpCustomerwithEmail(Customer cust, String password) async {
    processing = true;
    notifyListeners();
    String result = await _signUpWithEmail(cust.email!, password);
    if (result != "SUCCESS") {
      processing = false;
      notifyListeners();
      return result;
    }

    _customer = cust;
    await DbServices.addCustomer(_customer!, user!.uid);
    processing = false;
    notifyListeners();
    return "SUCCESS";
  }

  //Redirects to either welcome screen or home screen
  void redirectToScreen(BuildContext context) async {
    if (user == null) {
      Navigator.pushReplacementNamed(context, RouteManager.welcomeScreen);
    } else {
      bool isCustomer = await DbServices.isCustomer(user!);
      if (isCustomer) {
        _customer = await DbServices.getCustomer(user!.uid);
        Navigator.pushNamedAndRemoveUntil(
            context, RouteManager.customerHomeScreen, (route) => false);
      } else {
        //TODO: Get the restaurant object and set it
        Navigator.pushNamedAndRemoveUntil(
            context, RouteManager.restaurantHomeScreen, (route) => false);
      }
    }
  }

  Future<bool> emailExists(String email) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email, password: "someBOdyNeverGOOnnaUsEthisPassWOrDDMDK");
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "user-not-found":
          return false;
        case "invalid-email":
          return false;
        case "unknown":
          return false;
      }
    }
    return true;
  }

  Future<String> signInWithGoogle() async {
    User? user;
    processing = true;
    notifyListeners();
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount == null) {
      processing = false;
      notifyListeners();
      return "You have cancelled the sign in process !";
    }

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    try {
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      user = userCredential.user;
      await DbServices.addCustomer(
          Customer(
            name: user!.displayName,
            email: user.email,
            phone: user.phoneNumber,
          ),
          user.uid);
    } on FirebaseAuthException catch (e) {
      processing = false;
      notifyListeners();
      return e.message!;
    } catch (e) {
      processing = false;
      notifyListeners();
      return e.toString();
    }

    processing = false;
    notifyListeners();
    return "SUCCESS";
  }

  Future<void> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await _auth.signOut();
    _customer = null;
    notifyListeners();
  }
}
