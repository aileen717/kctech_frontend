import 'package:flutter/material.dart';
import 'package:kandahar/screens/availability.dart';

class Accommodation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      resizeToAvoidBottomInset: false,
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
                  'ROOMS',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                buildRoomCard(
                  name: 'Deluxe Room',
                  imagePath: 'assets/Room1.jpg',
                  price: 'PHP 3,300',
                  context: context,
                ),
                buildRoomCard(
                  name: 'Standard Room',
                  imagePath: 'assets/Room4.jpg',
                  price: 'PHP 2,000',
                  context: context,
                ),
                buildRoomCard(
                  name: 'Single Room',
                  imagePath: 'assets/Room3.jpg',
                  price: 'PHP 1,200',
                  context: context,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRoomCard({
    required String name,
    required String imagePath,
    required String price,
    required BuildContext context,
  }) {
    return Card(
      color: Colors.grey[300],
      elevation: 7.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              name,
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 13.0),
            Image.asset(
              imagePath,
              height: 200.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10.0),
            Text(
              price,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey[700],
              ),
            ),
            Text(
              'per night',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Availability(),
                      ),
                    );
                  },
                  child: Text('Check Availability'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown[400],
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}