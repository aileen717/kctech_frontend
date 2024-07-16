import 'package:flutter/material.dart';
import 'package:kandahar/widgets/custom_button.dart';
import 'package:kandahar/widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        backgroundColor: Colors.brown[300],
        title: Text(
            'Login',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        ),
      body: Center(
        child: Padding(
         padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 70.0,
                backgroundImage: AssetImage('assets/448878943_830805581902901_7913759342511156959_n.png'),
              ),
           
              SizedBox(height: 20.0,),
              CustomTextField(
                label: 'Email',
                icon: Icon(Icons.email), // Icon for Email field
              ),
              SizedBox(height: 20.0),
              CustomTextField(
                label: 'Password',
                isPassword: true,
                icon: Icon(Icons.lock), // Icon for Password field
              ),
              SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomButton(
                    text: 'Login',
                    onPressed: () {
                      // Implement login functionality here
                    },

                  ),
                ],
              ),
              SizedBox(height: 10.0),
              TextButton(
                onPressed: () {
                  // Navigate to registration screen
                  Navigator.pushNamed(context, '/register');
                },
                child: Text('Create an account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
