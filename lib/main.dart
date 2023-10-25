import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:movie_library/dto/AuthDTO.dart';
import 'package:movie_library/dto/MovieDTO.dart';
import 'package:movie_library/pages/home.dart';
import 'package:movie_library/pages/login.dart';
import 'package:movie_library/pages/movie_detail.dart';
import 'package:movie_library/pages/suggestion.dart';

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
      home: const LoginPage(),
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
            return MaterialPageRoute(
              builder: (context) => const ProfilePage(),
            );
          default:
            return null;
        }
      },
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
    );
  }
}
