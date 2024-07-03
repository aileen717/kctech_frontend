import 'package:flutter/material.dart';
import 'package:kandahar/screens/login_screen.dart';
import 'package:kandahar/screens/registration.dart';
import 'package:kandahar/screens/accommodations.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Registration App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/accommodations',
      routes: {
        '/login': (context) => LoginScreen(),
        '/register' : (context) => Registration(),
        '/accommodations' : (context) => Accommodations(),
      },
    );
  }
}
