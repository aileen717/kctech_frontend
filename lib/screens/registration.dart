import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Registration extends StatefulWidget {
  @override
  State<Registration> createState() => _SignupState();
}
class _SignupState extends State<Registration> {
  final formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String password = '';
  String address = '';
  String phoneNumber = '';
  bool _obscure = true;
  IconData _obscureIcon = Icons.visibility_off;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.brown[100],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(15.0, 50.0, 10.0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
                          return 'Name should be atleast 3 letters long';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        name = value!;
                      },
                    ),
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
                          icon: Icon(Icons.visibility_off_outlined),
                          onPressed: (){
                            setState(() {
                              _obscure=!_obscure;
                              if(_obscure){
                                _obscureIcon = Icons.visibility_off;
                              }else{
                                _obscureIcon = Icons.visibility_off;
                              }
                            });
                          },
                        ),

                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please provide a password';
                        }
                        if (value.length < 8) {
                          return 'Password should be atleast 8 characters long';
                        }
                        if (value.length > 20) {
                          return 'Password should be atleast 20 characters long';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        password = value!;
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
                          print(email);
                          print(password);
                          print(address);
                          print(phoneNumber);
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
