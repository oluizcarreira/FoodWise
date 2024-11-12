// Arquivo: main.dart
import 'package:flutter/material.dart';
import 'loading_screen.dart';
import 'welcome_screen.dart';
import 'register_name_screen.dart';
import 'register_gender_screen.dart';
import 'register_email_password_screen.dart';
import 'login_screen.dart';
import 'home_screen.dart';

void main() {
  runApp(FoodWiseApp());
}

class FoodWiseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Wise',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoadingScreen(),
        '/welcome': (context) => WelcomeScreen(),
        '/register_name': (context) => RegisterNameScreen(),
        '/register_gender': (context) => RegisterGenderScreen(),
        '/register_email_password': (context) => RegisterEmailPasswordScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}