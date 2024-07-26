import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kandahar/services/user.dart';

class Registration2 extends StatefulWidget {
  @override
  State<Registration2> createState() => _SignupState();
}

class _SignupState extends State<Registration2> {
  final formKey = GlobalKey<FormState>();
  String name = '';
  String address = '';
  String phoneNumber = '';

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
                    TextFormField(
                      decoration: InputDecoration(
                        label: Text('Name'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please provide a name';
                        }
                        if (value.length < 2) {
                          return 'Name should be at least 3 letters long';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        name = value!;
                      },
                    ),
                    SizedBox(height: 10.0,),
                    TextFormField(
                      decoration: InputDecoration(
                        label: Text('Address'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please provide your address';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        address = value!;
                      },
                    ),
                    SizedBox(height: 10.0,),
                    TextFormField(
                      decoration: InputDecoration(
                        label: Text('Phone Number'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please provide your phone number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        phoneNumber = value!;
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          print(name);
                          print(address);
                          print(phoneNumber);
                          Navigator.pushReplacementNamed(context, '/');
                        }
                      },
                      child: Text('Sign Up'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown[400],
                        foregroundColor: Colors.black,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Divider(
                              color: Colors.brown,
                            )),
                        SizedBox(
                          width: 10,
                          height: 30.0,
                        ),
                        Text("or"),
                        SizedBox(width: 10),
                        Expanded(child: Divider(
                          color: Colors.brown,
                        ))
                      ],
                    ),
                    SizedBox(
                      width: 20.0,
                      height: 5.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        ElevatedButton.icon(
                          onPressed: () {

                          },
                          icon: Icon(Icons.g_mobiledata_rounded),
                          label: Text('Log in with Google'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            foregroundColor: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        ElevatedButton.icon(
                          onPressed: () {

                          },
                          icon: Icon(Icons.facebook),
                          label: Text('Log in with Facebook'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[900],
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
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