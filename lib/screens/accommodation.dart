import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: Accommodation(),
  ));
}

class Accommodations {
  final String name;
  final String type;
  final double price;

  Accommodations({
    required this.name,
    required this.type,
    required this.price,
  });

  factory Accommodations.fromJson(Map<String, dynamic> json) {
    return Accommodations(
      name: json['name'],
      type: json['type'],
      price: json['price'].toDouble(),
    );
  }
}

class Accommodation extends StatefulWidget {
  @override
  State<Accommodation> createState() => _AccommodationState();
}

class _AccommodationState extends State<Accommodation> {
  late Future<List<Accommodations>> accommodations;

  Future<List<Accommodations>> fetchData() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8080/api/v1/all'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      List<Accommodations> accommodations = data.map((json) => Accommodations.fromJson(json)).toList();
      return accommodations;
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  void initState() {
    super.initState();
    accommodations = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                color: Colors.brown[500],
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
            preferredSize: Size.fromHeight(150.0),
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
          SizedBox(height: 15.0), // Spacer between title and buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('All'),
              _buildButton('Rooms'),
              _buildButton('Cottages'),
            ],
          ),
          SizedBox(height: 20.0), // Spacer below buttons
          Expanded(
            child: FutureBuilder<List<Accommodations>>(
              future: accommodations,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  List<Accommodations> accommodations = snapshot.data!;
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: accommodations.length,
                      itemBuilder: (context, index) {
                        return _buildCard(accommodations[index]);
                      },
                    ),
                  );
                } else {
                  return Center(child: Text('No data available'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String label) {
    return ElevatedButton(
      onPressed: () {
        print('Pressed $label');
      },
      child: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.brown[200],
        foregroundColor: Colors.black,
        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
      ),
    );
  }

  Widget _buildCard(Accommodations accommodations) {
    return Card(
      margin: EdgeInsets.all(8.0),
      color: Colors.brown[300],
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              accommodations.name,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              'Type: ${accommodations.type}', // Display type here
              style: TextStyle(fontSize: 16.0, color: Colors.grey[800]),
            ),
            Text(
              'Price: ${accommodations.price.toString()}',
              style: TextStyle(fontSize: 16.0, color: Colors.grey[800]),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SelectedAccommodations(accommodations: accommodations),
            ),
          );
        },
      ),
    );
  }
}

class SelectedAccommodations extends StatelessWidget {
  final Accommodations accommodations;

  SelectedAccommodations({required this.accommodations});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(accommodations.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Name: ${accommodations.name}',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Type: ${accommodations.type}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              'Price: ${accommodations.price}',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
