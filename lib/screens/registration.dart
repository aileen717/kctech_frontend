import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kandahar/services/user.dart';
import 'package:kandahar/screens/registration2.dart';

class Registration extends StatefulWidget {
  @override
  State<Registration> createState() => _SignupState();
}

class _SignupState extends State<Registration> {
  final formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool _obscure = true;
  IconData obscureIcon = Icons.visibility_off;

  createAccount(User user) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/api/v1/auth/register/user'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'username': user.username,
        'email': user.email,
        'password': user.password,
      }),
    );
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.brown[100],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(15.0, 50.0, 10.0, 0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 90.0,
                    backgroundImage: AssetImage('assets/448878943_830805581902901_7913759342511156959_n.png'),
                  ),
                ],
              ),
              Text(
                '',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2.0,
                  fontSize: 25.5,
                ),
              ),
              Text(
                'Let`s Get Started!',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2.0,
                  fontSize: 25.5,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: 10.0,),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        label: Text('Email'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please provide a valid email';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        email = value!;
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      obscureText: _obscure,
                      decoration: InputDecoration(
                        label: Text('Password'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(obscureIcon),
                          onPressed: () {
                            setState(() {
                              _obscure = !_obscure;
                              obscureIcon = _obscure ? Icons.visibility_off : Icons.visibility;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please provide a password';
                        }
                        if (value.length < 8) {
                          return 'Password should be at least 8 characters long';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        password = value!;
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          print(email);
                          print(password);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Registration2(),  // Add appropriate parameters if needed
                            ),
                          );
                        }
                      },
                      child: Text('Proceed'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown[400],
                        foregroundColor: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
