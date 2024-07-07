import 'package:flutter/material.dart';
import 'package:kandahar/screens/home.dart';
import 'package:kandahar/screens/availability.dart';


void main() => runApp(MaterialApp(
  initialRoute: '/availability',
  routes: {
    '/home': (context) => MyHomePage(),
    '/availability': (context) => Availability(),
  },
));