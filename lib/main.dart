import 'package:eatopia_refactored/firebase/authentication/auth_services.dart';
import 'package:eatopia_refactored/routes/routes.dart';
import 'package:eatopia_refactored/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeManager()),
          ChangeNotifierProvider(create: (_) => AuthServices()),
        ],
        builder: (context, child) {
          return MaterialApp(
            theme: ThemeData.from(colorScheme: lightColorScheme),
            darkTheme: ThemeData.from(colorScheme: darkColorScheme),
            debugShowCheckedModeBanner: false,
            themeMode: context.watch<ThemeManager>().themeMode,
            title: 'Eatopia',
            initialRoute: RouteManager.splashScreen,
            onGenerateRoute: RouteManager.generateRoute,
          );
        });
  }
}
