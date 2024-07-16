import 'package:flutter/material.dart';
import 'package:kandahar/widgets/custom_button.dart';
import 'package:kandahar/widgets/custom_text_field.dart';

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.brown[300],
        title: Text(
            'Registration',
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
                radius: 50.0,
                backgroundImage: AssetImage('assets/448878943_830805581902901_7913759342511156959_n.png'),
              ),
              CustomTextField(label: 'Full Name'),
              SizedBox(height: 10.0),
              CustomTextField(label: 'Email'),
              SizedBox(height: 5.0),
              CustomTextField(label: 'Phone Number'),
              SizedBox(height: 5.0),
              CustomTextField(label: 'Address'),
              SizedBox(height: 5.0),
              CustomTextField(label: 'Password', isPassword: true),
              SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomButton(
                    text: 'Register',

                    onPressed: () {
                      // Implement registration functionality here
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
