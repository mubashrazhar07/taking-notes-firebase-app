import 'package:flutter/material.dart';
import 'package:taking_notes_firebase_app/routes/routes_names.dart';
import 'package:taking_notes_firebase_app/ui/splashscreen.dart';

class CustomRouter {
  static Route<dynamic> allRoutes(RouteSettings settings) {
    switch (settings.name) {
      case splashScreenRoute:
        return MaterialPageRoute(
          builder: (_) =>  const SplashScreen(),
        );
      default:
        return MaterialPageRoute(
            builder: (_) =>  const Scaffold(
                  backgroundColor: Colors.blue,
                ));
    }
  }
}
