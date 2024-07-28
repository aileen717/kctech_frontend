import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late Map<String, dynamic> profile;

  buildShowDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: SpinKitCubeGrid(
            color: Colors.brown,
            size: 100,
          ),
        );
      },
    );
  }

  Future<Map<String, dynamic>> _loadCredential() async {
    final prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');

    return <String, dynamic>{
      'email': email ?? '',
      'password': password ?? '',
    };
  }

  Future<Map<String, dynamic>> _getUserInfo() async {
    final userCredentials = await _loadCredential();
    final response = await http.get(
      Uri.parse(
          'http://10.0.2.2:8080/api/v1/profile/account/${userCredentials['email']}'),
      headers: <String, String>{'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final result = <String, dynamic>{};
      result.addAll(data);
      result.addAll(<String, String>{'email': userCredentials['email']});
      return result;
    } else {
      throw Exception('Failed to load profile data');
    }
  }

  Future<bool> _logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('email');
      await prefs.remove('password');
      return true;
    } catch (err) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.brown[300],
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _getUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitCubeGrid(
                color: Colors.brown,
                size: 100,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            profile = snapshot.data!;
            return Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/shiba.png'),
                          backgroundColor: Colors.grey[200],
                          radius: 65.0,
                        ),
                      ),
                      Divider(
                        height: 48.0,
                        color: Colors.grey[200],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.person_2,
                            color: Colors.grey[200],
                          ),
                          SizedBox(
                            width: 3.0,
                          ),
                          Text(
                            'NAME',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[200],
                              letterSpacing: 2.0,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        profile['name'] ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[200],
                          fontSize: 25.0,
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.phone,
                            color: Colors.grey[200],
                          ),
                          SizedBox(
                            width: 3.0,
                          ),
                          Text(
                            'MOBILE NUMBER',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[200],
                              letterSpacing: 2.0,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        profile['contact'] ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[200],
                          fontSize: 25.0,
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.grey[200],
                          ),
                          SizedBox(
                            width: 3.0,
                          ),
                          Text(
                            'ADDRESS',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[200],
                              letterSpacing: 2.0,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        profile['address'] ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[200],
                          fontSize: 25.0,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          buildShowDialog(context);
                          _logout().then((result) {
                            if (result) {
                              Navigator.pushReplacementNamed(context, '/login');
                            } else {
                              Navigator.of(context).pop();
                            }
                          });
                        },
                        child: Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.blue[900],
                            fontSize: 16.0,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.grey[200]),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text('No data available'),
            );
          }
        },
      ),
    );
  }
}
