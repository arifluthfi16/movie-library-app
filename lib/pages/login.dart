import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_library/components/CustomButton.dart';
import 'package:movie_library/components/ThemeWrapper.dart';
import 'package:movie_library/dto/AuthDTO.dart';

import '../api/AuthAPI.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              color: Colors.white
          ),
          padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 24),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 32),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Movie Library',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF090A0A),
                        fontSize: 28,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 8,),
                    Icon(
                      Icons.movie,
                      size: 28.0,
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Log in to use the App',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextField(
                        controller: usernameController,
                        obscureText: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Username',
                        )
                    ),
                    const SizedBox(height: 16),
                    TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        )
                    ),
                  ],
                ),
              ),
              CustomButton(
                text: "Login",
                backgroundColor: const Color(0xFF6A4DFF),
                onPressed: () async {
                  if (usernameController.text.isNotEmpty && passwordController.text.isNotEmpty)  {
                    try {
                      LoginResponseDTO responseDTO = await AuthAPI.login(usernameController.text, passwordController.text);
                      if (responseDTO.data?.isNotEmpty ?? false) {
                        storage.write(key: "auth_token", value: responseDTO.data);
                        UserResponseDTO userResponse = await AuthAPI.getCurrentUser();
                        UserDTO user = userResponse.data;
                        Navigator.of(context).pushReplacementNamed(
                            "/home",
                          arguments: user
                        );
                        Fluttertoast.showToast(
                            msg: "Login Success",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 2,
                            backgroundColor: Colors.lightGreen,
                            textColor: Colors.blue,
                            fontSize: 16.0
                        );
                      } else {
                        Fluttertoast.showToast(
                            msg: responseDTO.message,
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 2,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                    } catch (e) {
                      Fluttertoast.showToast(
                          msg: "Login failed, $e",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}