import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:movie_library/components/CustomSplashScreen.dart';
import 'package:movie_library/dto/AuthDTO.dart';
import 'package:movie_library/dto/MovieDTO.dart';
import 'package:movie_library/pages/home.dart';
import 'package:movie_library/pages/login.dart';
import 'package:movie_library/pages/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      home: const CustomSplashScreen(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/home':
            final user = settings.arguments as UserDTO;
            return MaterialPageRoute(
              builder: (context) => HomeScreen(user: user),
            );
          case '/login':
            return MaterialPageRoute(
              builder: (context) => const LoginPage(),
            );
          case '/profile':
            final user = settings.arguments as UserDTO;
            return MaterialPageRoute(
              builder: (context) => ProfileScreen(user: user),
            );
          default:
            return null;
        }
      },
    );
  }
}
