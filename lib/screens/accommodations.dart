import 'package:flutter/material.dart';

class Accommodations extends StatefulWidget {
  const Accommodations({Key? key}) : super(key: key);

  @override
  State<Accommodations> createState() => _AccommodationsState();
}

class _AccommodationsState extends State<Accommodations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: Text(
          'Kandahar Cottages',
          style: TextStyle(
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.brown[300],
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.brown[700],
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.black,
              width: 2.0,
            ),
          ),
          child: Text(
            'Accommodations',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
