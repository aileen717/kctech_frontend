import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kandahar/services/user.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool _obscure = true;
  IconData obscureIcon = Icons.visibility_off;

  Widget buttonContent = Text('Log in');
  Widget loadingDisplay = CircularProgressIndicator();
  Future<bool> login(User user)async{
    final response = await http.post(
        Uri.parse('http://10.0.2.2:8080/api/v1/auth/login'),
        headers: <String, String>{
          'Content-Type' : 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          'usernameOrEmail' : user.email,
          'password' : user.password
        })
    );
    if(response.statusCode == 200){
      return true;
    }
    return false;
    //print(response.body);
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
        radius: 70.0,
           backgroundImage: AssetImage('assets/448878943_830805581902901_7913759342511156959_n.png'),
          ),
        ],
        ),
          Text(
            'Welcome to Kandahar!',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              letterSpacing: 2.0,
              fontSize: 25.0,
            ),
          ),

            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
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
                  SizedBox(height: 30.0),
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
                              obscureIcon = Icons.visibility_off;
                            }else{
                              obscureIcon = Icons.visibility_off;
                            }
                          });
                        },
                      ),

                    ),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please provide a password';
                      }
                      if (value.length < 8 || value.length > 20) {
                        return 'Password should be between 8 and 20 characters long';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      password = value!;
                    },
                  ),
                  SizedBox(height: 30.0,),
                  ElevatedButton(
                    onPressed: (){
                      if(formKey.currentState!.validate()){
                        formKey.currentState!.save();
                        User user = User(
                          id: '',
                          username: '',
                          email: email,
                          password: password,
                        );
                        setState(() {
                          buttonContent = FutureBuilder(
                              future: login(user),
                              builder: (context, snapshots){
                                if(snapshots.connectionState == ConnectionState.waiting){
                                  return loadingDisplay;
                                }
                                if(snapshots.hasData){
                                }
                                return Text('Log in');
                              }
                          );
                        });
                        //Navigator.pushReplacementNamed(context, '/');
                      }
                    },
                    child: buttonContent,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown[400],
                      foregroundColor: Colors.black,
                    ),
                  ),
                  SizedBox(height: 30.0,),
                  Row(
                    children: [
                      Text(
                        'Don`t have an account?',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 5.0,),
                      InkWell(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.orange[400],
                          ),
                        ),
                        onTap: ()=> Navigator.popAndPushNamed(context, '/registration'),
                      )
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