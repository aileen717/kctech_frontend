import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kandahar/main.dart';
import 'package:kandahar/services/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool _obscure = true;
  IconData _obscureIcon = Icons.visibility_off;

  Widget buttonContent = Text('Log in');
  Widget loadingDisplay = CircularProgressIndicator();

  Future<String> _saveCredentials(String _email, String _password) async {
    try {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final userId = await getUserId(email, password);
      await prefs.setString('email', _email);
      await prefs.setString('password', _password);
      await prefs.setInt('userId', userId);
      setState(() {
        email = _email;
        password = _password;
      });

      return '';
    } catch (err) {
      return err.toString();
    }
  }

  Future<int> getUserId(String email, String password) async {
    final basicAuth = base64Encode(utf8.encode('$email:$password'));
    final response = await http.get(
        Uri.parse('http://10.0.2.2:8080/api/v1/profile/$email'),
        headers: <String, String>{
          'Authorization': 'Basic $basicAuth',
          'Content-Type': 'application/json'
        }
    );
    return int.parse(response.body);
  }

  Future<bool> login(UserAuth userAuth) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/api/v1/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, dynamic>{
        'usernameOrEmail': userAuth.email,
        'password': userAuth.password,
      }),
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.brown[100],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(30.0, 60.0, 30.0, 0),
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
                  fontSize: 25.0,
                ),
              ),
              Text(
                'Welcome to Kandahar!',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2.0,
                  fontSize: 25.0,
                ),
              ),
              SizedBox(height: 50.0),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFormField(
                      style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.emailAddress,
                      maxLength: 60,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email address';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        email = value!;
                      },
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      style: TextStyle(color: Colors.black),
                      enableInteractiveSelection: false,
                      obscureText: _obscure,
                      maxLength: 20,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(_obscureIcon, color: Colors.black),
                          onPressed: () {
                            setState(() {
                              _obscure = !_obscure;
                              if (_obscure) {
                                _obscureIcon = Icons.visibility_off;
                              } else {
                                _obscureIcon = Icons.visibility;
                              }
                            });
                          },
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 8) {
                          return 'Password must be 8 or more characters';
                        }
                        if (value.length > 20) {
                          return 'Password must be 20 characters long only';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        password = value!;
                      },
                    ),
                    SizedBox(height: 10.0),
                    SizedBox(
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            UserAuth user = UserAuth(
                              username: '',
                              email: email,
                              password: password,
                            );
                            setState(() {
                              buttonContent = loadingDisplay;
                            });

                            bool success = await login(user);
                            if (success) {
                              _saveCredentials(email, password).then((result) {
                                if (result == '') {
                                  Navigator.pushReplacementNamed(context, '/profile');
                                } else {
                                  print(result);
                                }
                              });
                            } else {
                              setState(() {
                                buttonContent = Text('Log in');
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Login failed. Please check your credentials.'),
                                ),
                              );
                            }
                          }
                        },
                        child: buttonContent,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown[300],
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Divider(
                            color: Colors.brown[300],
                            height: 50,
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          "or",
                          style: TextStyle(color: Colors.brown[300]),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          child: Divider(
                            color: Colors.blue[900],
                            height: 50,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Don\'t have an account?',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        InkWell(
                          child: Text(
                            'Signup Here',
                            style: TextStyle(
                              color: Colors.blue[300],
                              decoration: TextDecoration.underline,
                              fontSize: 15.0,
                            ),
                          ),
                          onTap: () =>
                              Navigator.pushReplacementNamed(context, '/registration'),
                        ),
                      ],
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
