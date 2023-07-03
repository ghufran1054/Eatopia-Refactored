import 'package:eatopia_refactored/views/common/login_screen.dart';
import 'package:eatopia_refactored/views/common/map_screen.dart';
import 'package:eatopia_refactored/views/customer/customer_home_screen.dart';
import 'package:eatopia_refactored/views/customer/sign_up_screen.dart';
import 'package:eatopia_refactored/views/common/splash_screen.dart';
import 'package:eatopia_refactored/views/common/welcome_screen.dart';
import 'package:eatopia_refactored/views/restaurant/restaurant_home_screen.dart';
import 'package:flutter/material.dart';

import '../views/restaurant/restaurant_sign_up.dart';

class RouteManager {
  static const String splashScreen = '/';
  static const String welcomeScreen = '/welcomeScreen';
  static const String loginScreen = '/loginScreen';
  static const String userSignUpScreenOne = '/userSignUpScreenOne';
  static const String userSignUpScreenTwo = '/userSignUpScreenTwo';
  static const String customerHomeScreen = '/customerHomeScreen';
  static const String restaurantHomeScreen = '/restaurantHomeScreen';
  static const String businessSignUpScreen = '/businessSignUpScreen';
  static const String mapScreen = '/mapScreen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const SplashScreen(),
        );
      case welcomeScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const WelcomePage(),
        );
      case loginScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const LoginScreen(),
        );
      case userSignUpScreenOne:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const UserSignUpScreenOne(),
        );
      case userSignUpScreenTwo:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const UserSignUpScreenTwo(),
        );
      case customerHomeScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const CustomerHomeScreen(),
        );
      case restaurantHomeScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const RestaurantHomeScreen(),
        );
      case businessSignUpScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const BusinessSignUpScreen(),
        );
      case mapScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const MapScreen(),
        );
      default:
        return MaterialPageRoute<dynamic>(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
