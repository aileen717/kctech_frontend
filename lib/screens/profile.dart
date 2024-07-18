import 'package:flutter/material.dart';

class Profile extends StatefulWidget {

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kandahar Cottages'),
        backgroundColor: Colors.brown[600],
        centerTitle: true,
        toolbarHeight: 110.0,
      ),

      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
      PreferredSize(
      preferredSize: Size.fromHeight(80.0),
      child: Container(
        color: Colors.brown[400],
        child: Center(
          child: Text(
            'My Profile',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
      ),
    ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                color: Colors.brown[100],
                child: Text(
                  '    User Information : ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
    ],
      ),
    );
  }
}
