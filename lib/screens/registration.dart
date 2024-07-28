import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kandahar/services/user.dart';

class Registration extends StatefulWidget {
  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final formKey = GlobalKey<FormState>();
  String name = 'kandahar';
  String email = '';
  String password = '';
  String confirmPassword = '';
  bool _obscure = true;
  bool _obscureConfirmPassword = true;
  IconData obscureIcon = Icons.visibility_off;
  IconData _obscureConfirmPasswordIcon = Icons.visibility_off;

  Future<String> _saveCredentials(String _email, String _password) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userAuthId = await getUserAuthId(_email, _password);
      await prefs.setString('email', _email);
      await prefs.setString('password', _password);
      await prefs.setInt('userAuthId', userAuthId);
      return '';
    } catch (err) {
      return err.toString();
    }
  }

  Future<int> getUserAuthId(String $email, String password) async {
    final basicAuth = base64Encode(utf8.encode('$email:$password'));
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8080/api/v1/profile/$email'),
      headers: <String, String>{
        'Authorization': 'Basic $basicAuth',
        'Content-Type': 'application/json',
      },
    );
    print(response.body.toString());
    return int.parse(response.body);
  }

  Future<void> createAccount(UserAuth userAuth) async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8080/api/v1/auth/register/user'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'name': userAuth.username,
          'email': userAuth.email,
          'password': userAuth.password,
        }),
      );

      print(response.body);

      if (response.statusCode == 200) {
        Navigator.pushReplacementNamed(context, '/registration2');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.reasonPhrase}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
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
                  fontSize: 15.5,
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
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      obscureText: _obscureConfirmPassword,
                      decoration: InputDecoration(
                        label: Text('Confirm Password'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(_obscureConfirmPasswordIcon),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword = !_obscureConfirmPassword;
                              _obscureConfirmPasswordIcon = _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != password) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        confirmPassword = value;
                      },
                    ),
                    SizedBox(height: 15.0),
                    SizedBox(
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            if (password == confirmPassword) {
                              UserAuth userAuth = UserAuth(id: 0, username: name, email: email, password: password);
                              createAccount(userAuth).then((_) {
                                _saveCredentials(email, password).then((result) {
                                  if (result == '') {
                                    Navigator.pushReplacementNamed(context, '/registration2');
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('An error occurred: $result')),
                                    );
                                  }
                                });
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Passwords do not match')),
                              );
                            }
                          }
                        },
                        child: Text('Register'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown[400],
                          foregroundColor: Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      '',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2.0,
                        fontSize: 15.5,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account? "),
                        InkWell(
                          child: Text(
                            'Log In Here',
                            style: TextStyle(
                              color: Colors.blue[600],
                            ),
                          ),
                          onTap: () =>
                              Navigator.popAndPushNamed(context, '/login'),
                        ),
                      ],
                    )
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
