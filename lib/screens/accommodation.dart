import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Accommodation(),
  ));
}
class Accommodation extends StatefulWidget {
  @override
  State<Accommodation> createState() => _AccommodationState();
}

class _AccommodationState extends State<Accommodation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        title: Text('Kandahar Cottages'),
        backgroundColor: Colors.brown[600],
        centerTitle: true,
        toolbarHeight: 70.0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.brown[900],
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('My Profile'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.history_sharp),
              title: Text('History'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle_outlined),
              title: Text('Account'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          PreferredSize(
            preferredSize: Size.fromHeight(100.0),
            child: Container(
              color: Colors.brown[400],
              child: Center(
                child: Text(
                  'Accommodations',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0), // Spacer between title and buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('All'),
              _buildButton('Rooms'),
              _buildButton('Cottages'),
            ],
          ),
          SizedBox(height: 20.0), // Spacer below buttons
        ],
      ),
    );
  }

  Widget _buildButton(String label) {
    return ElevatedButton(
      onPressed: () {
        // Handle button tap
        print('Pressed $label');
      },
      child: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.brown[200],
        foregroundColor: Colors.black,
        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 5.0),
      ),
    );
  }
}