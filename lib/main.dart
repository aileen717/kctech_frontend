import 'package:flutter/material.dart';
import 'package:kandahar/screens/accommodation.dart';
import 'package:kandahar/screens/home.dart'; // Import the correct home screen widget

import 'package:kandahar/screens/login.dart';
import 'package:kandahar/screens/registration.dart';
import 'package:kandahar/screens/profile.dart';
import 'package:kandahar/screens/bookingdetails.dart';
import 'package:kandahar/screens/summary.dart';
import 'package:kandahar/screens/confirmation.dart';


void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/' : (context) => HomeScreen(),
    '/login' : (context) => Login(),
    '/registration' : (context) => Registration(),
    '/accommodation' : (context) => Accommodation(),
    '/bookings' : (context) => Bookings(),
    '/profile' : (context) => Profile(),
    '/summary' : (context) => Summary(),
    '/confirmation' : (context) => Confirmation(),
  },
));

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [

    MyHomePage(), // Assuming MyHomePage is your home screen widget
    Accommodation(),
    Bookings(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.brown[400],
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.beach_access),
            label: 'Accommodations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmarks_outlined),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
