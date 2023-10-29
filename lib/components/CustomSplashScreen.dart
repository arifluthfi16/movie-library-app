import 'package:flutter/material.dart';

class CustomSplashScreen extends StatelessWidget {
  const CustomSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context).pushReplacementNamed("/login");
      }),
      builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: Color(0xFF6A4DFF),
          body: Center(
            child: AnimatedOpacity(
              opacity: snapshot.connectionState == ConnectionState.done ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 500),
              child: const Icon(
                Icons.movie,
                size: 72.0,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
