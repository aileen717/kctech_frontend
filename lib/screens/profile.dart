import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('User Profile'),
        backgroundColor: Colors.brown,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 90.0,
                  backgroundColor: Colors.brown[600],
                  child: CircleAvatar(
                    radius: 85.0,
                    backgroundColor: Colors.brown[100],
                    backgroundImage: AssetImage('assets/861f9d87a1e0b784b8a11a354f314f61.jpg'),
                  ),
                ),
                Divider(
                  height: 50.0,
                  color: Colors.brown[500],
                  thickness: 5.0,
                ),
                SizedBox(height: 30.0),
                // Name Card
                Card(
                  color: Colors.grey[300],
                  elevation: 3.0,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.brown,
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          'Name:',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                            letterSpacing: 2.0,
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          '',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                // Email Card
                Card(
                  color: Colors.grey[300],
                  elevation: 3.0,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.email,
                          color: Colors.brown,
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          'Email:',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                            letterSpacing: 2.0,
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          child: Text(
                            '',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Card(
                  color: Colors.grey[300],
                  elevation: 3.0,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_pin,
                          color: Colors.brown,
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          'Address:',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                            letterSpacing: 2.0,
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          child: Text(
                            '',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                // Phone Number Card
                Card(
                  color: Colors.grey[300],
                  elevation: 3.0,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.phone_android_rounded,
                          color: Colors.brown,
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          'Phone Number:',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                            letterSpacing: 2.0,
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          '',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Text('Log Out'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
