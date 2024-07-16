import 'package:flutter/material.dart';

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
  IconData _obscureIcon = Icons.visibility_off;

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
                      if (value.length < 8 || value.length > 20) {
                        return 'Password should be between 8 and 20 characters long';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      password = value!;
                    },
                  ),
                  SizedBox(height: 30.0),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        print(email);
                        print(password);
                      }
                    },
                    child: Text('Log In'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown[400],
                      foregroundColor: Colors.black,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Dont have an account? ',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      InkWell(
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.blue[900],
                          ),
                        ),
                        onTap: () =>
                            Navigator.pushNamed(context, '/registration'),
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